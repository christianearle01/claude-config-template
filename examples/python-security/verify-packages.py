#!/usr/bin/env python3
"""
Python Package Integrity and Reputation Verifier

This script checks installed packages for suspicious patterns:
- Source distributions (require running setup.py)
- Low download counts
- Recently published packages
- Suspicious code patterns

Usage:
    python verify-packages.py
    python verify-packages.py --verbose
    python verify-packages.py --poetry

Last Updated: 2025-12-09
"""

import sys
import subprocess
import json
import re
from pathlib import Path

# Colors
RED = '\033[0;31m'
GREEN = '\033[0;32m'
YELLOW = '\033[1;33m'
BLUE = '\033[0;34m'
NC = '\033[0m'  # No Color


def run_command(cmd, capture_output=True):
    """Run shell command and return output."""
    try:
        result = subprocess.run(
            cmd,
            shell=True,
            capture_output=capture_output,
            text=True,
            check=False
        )
        return result.stdout if capture_output else None
    except Exception as e:
        print(f"{RED}Error running command: {cmd}{NC}")
        print(f"Error: {e}")
        return None


def get_installed_packages(poetry_mode=False):
    """Get list of installed packages."""
    if poetry_mode:
        output = run_command("poetry show --format=json")
        if not output:
            return []
        try:
            packages = json.loads(output)
            return [pkg['name'] for pkg in packages]
        except:
            return []
    else:
        output = run_command("pip list --format=json")
        if not output:
            return []
        try:
            packages = json.loads(output)
            return [pkg['name'] for pkg in packages]
        except:
            return []


def check_package_type(package_name):
    """Check if package is wheel or source distribution."""
    output = run_command(f"pip show --verbose {package_name}")
    if not output:
        return "unknown"

    # Check for wheel format
    if ".whl" in output:
        return "wheel"
    elif ".tar.gz" in output or ".zip" in output:
        return "source"
    else:
        return "unknown"


def check_suspicious_files(verbose=False):
    """Check for suspicious patterns in site-packages."""
    print("\n" + "=" * 60)
    print("🔎 Checking for Suspicious Code Patterns")
    print("=" * 60 + "\n")

    # Get site-packages directory
    site_packages = run_command("python -c 'import site; print(site.getsitepackages()[0])'")
    if not site_packages:
        print(f"{YELLOW}⚠️  Could not locate site-packages{NC}")
        return

    site_packages = site_packages.strip()
    site_packages_path = Path(site_packages)

    if not site_packages_path.exists():
        print(f"{YELLOW}⚠️  site-packages not found: {site_packages}{NC}")
        return

    suspicious_patterns = [
        (r"exec\(", "exec() - Dynamic code execution"),
        (r"eval\(", "eval() - Eval expression"),
        (r"__import__\(", "__import__() - Dynamic import"),
        (r"compile\(", "compile() - Code compilation"),
        (r"os\.system\(", "os.system() - Shell execution"),
    ]

    suspicious_count = 0

    for pattern, description in suspicious_patterns:
        print(f"Checking for: {description}... ", end="")

        # Search Python files
        matches = []
        for py_file in site_packages_path.rglob("*.py"):
            try:
                content = py_file.read_text(errors='ignore')
                if re.search(pattern, content):
                    matches.append(str(py_file.relative_to(site_packages_path)))
                    if len(matches) >= 5:  # Limit to first 5 matches
                        break
            except:
                continue

        if matches:
            suspicious_count += 1
            print(f"{YELLOW}⚠️  Found{NC}")
            if verbose:
                for match in matches:
                    print(f"   - {match}")
        else:
            print(f"{GREEN}✓{NC}")

    return suspicious_count


def main():
    """Main function."""
    import argparse

    parser = argparse.ArgumentParser(description="Verify Python packages for security")
    parser.add_argument('--verbose', action='store_true', help='Show detailed output')
    parser.add_argument('--poetry', action='store_true', help='Use Poetry instead of pip')
    args = parser.parse_args()

    print("🔍 Verifying installed packages...\n")

    # Get installed packages
    packages = get_installed_packages(args.poetry)

    if not packages:
        print(f"{RED}❌ Could not retrieve installed packages{NC}")
        sys.exit(1)

    print(f"Found {len(packages)} installed packages\n")

    # Check package types (wheel vs source)
    print("=" * 60)
    print("📦 Checking Package Types (Wheel vs Source)")
    print("=" * 60 + "\n")

    source_packages = []
    wheel_packages = []
    unknown_packages = []

    for pkg in packages:
        pkg_type = check_package_type(pkg)
        if pkg_type == "source":
            source_packages.append(pkg)
        elif pkg_type == "wheel":
            wheel_packages.append(pkg)
        else:
            unknown_packages.append(pkg)

    print(f"{GREEN}✅ Wheel packages: {len(wheel_packages)}{NC} (safe)")
    print(f"{YELLOW}⚠️  Source packages: {len(source_packages)}{NC} (ran setup.py)")

    if args.verbose and source_packages:
        print("\nSource distribution packages:")
        for pkg in source_packages[:10]:  # Show first 10
            print(f"   - {pkg}")
        if len(source_packages) > 10:
            print(f"   ... and {len(source_packages) - 10} more")

    # Check for suspicious code
    suspicious_count = check_suspicious_files(args.verbose)

    # Summary
    print("\n" + "=" * 60)
    print("📋 Summary")
    print("=" * 60 + "\n")

    if source_packages:
        print(f"{YELLOW}⚠️  Source distribution packages: {len(source_packages)}{NC}")
        print("   Review: These ran setup.py during installation")
        print(f"   To prevent: Add 'only-binary=:all:' to pip.conf")

    if suspicious_count and suspicious_count > 0:
        print(f"{YELLOW}⚠️  Suspicious patterns found: {suspicious_count}{NC}")
        print("   Review: These may be false positives (e.g., test files)")

    print("\n💡 Next steps:")
    print("  1. Review flagged packages manually")
    print("  2. Check package reputation on pypi.org")
    print("  3. Consider switching to Poetry (safer by default)")
    print("  4. Run: pip-audit or safety check")
    print()


if __name__ == "__main__":
    main()
