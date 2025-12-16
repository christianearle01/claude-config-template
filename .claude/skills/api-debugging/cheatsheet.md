# API Debugging - Quick Reference

**Quick reference for common API errors, HTTP status codes, and debugging patterns.**

---

## HTTP Status Code Quick Lookup

### 2xx Success

| Code | Meaning | Common Cause |
|------|---------|--------------|
| **200** | OK | Request succeeded |
| **201** | Created | Resource created successfully (POST) |
| **204** | No Content | Success, but no response body (DELETE) |

---

### 4xx Client Errors

| Code | Meaning | Common Cause | Quick Fix |
|------|---------|--------------|-----------|
| **400** | Bad Request | Invalid request syntax | Check request body format |
| **401** | Unauthorized | Authentication required | Check token/credentials |
| **403** | Forbidden | Authenticated but not authorized | Check user permissions |
| **404** | Not Found | Resource doesn't exist | Check URL/endpoint |
| **422** | Unprocessable Entity | Validation failed | Check required fields |
| **429** | Too Many Requests | Rate limited | Implement backoff/retry |

---

### 5xx Server Errors

| Code | Meaning | Common Cause | Quick Fix |
|------|---------|--------------|-----------|
| **500** | Internal Server Error | Server crashed | Check server logs |
| **502** | Bad Gateway | Upstream server error | Check proxy/gateway config |
| **503** | Service Unavailable | Server overloaded | Wait and retry |
| **504** | Gateway Timeout | Upstream timeout | Increase timeout or optimize |

---

## Common Error Patterns

### CORS Issues

```
Error: Access-Control-Allow-Origin header is missing
Access to fetch at 'https://api.example.com' has been blocked by CORS policy
```

**Quick fix:**
1. Check backend CORS configuration
2. Verify request origin matches allowed origins
3. Check for `credentials: true` if using cookies
4. Ensure preflight OPTIONS request succeeds

**Common CORS mistakes:**
- Wildcard `*` with credentials (not allowed)
- Missing `Access-Control-Allow-Headers`
- Wrong `Access-Control-Allow-Methods`

---

### Authentication Failures

```
Error: 401 Unauthorized
Invalid token or token expired
```

**Debug checklist:**
- [ ] Is token included in request?
- [ ] Is token format correct? (Bearer, Basic, API Key, etc.)
- [ ] Has token expired?
- [ ] Is token in correct header? (Authorization, X-API-Key, etc.)
- [ ] Does token have required permissions?

**Common auth mistakes:**
- Forgetting `Bearer ` prefix: `Authorization: Bearer YOUR_TOKEN`
- Token in wrong header
- Token expired but not refreshed
- CORS prevents Authorization header

---

### Timeout Issues

```
Error: Request timeout after 30s
ETIMEDOUT: Connection timed out
```

**Investigate:**
1. **Network latency** - Use Operation 3 to measure
2. **Server processing time** - Check server metrics
3. **Database query performance** - Slow queries?
4. **Upstream service delays** - Third-party API slow?

**Quick fixes:**
- Increase client timeout (if server is legit slow)
- Optimize slow database queries
- Add caching layer
- Use async processing for long operations

---

### Validation Errors

```
Error: 422 Unprocessable Entity
Validation failed: email is required
```

**Steps:**
1. Check request body against API schema
2. Verify all required fields present
3. Check data types match expected (string vs number)
4. Look for extra/unexpected fields
5. Check field length/format constraints

**Common validation mistakes:**
- Sending string when number expected
- Missing required fields
- Wrong date format (ISO 8601 expected)
- Extra whitespace in values

---

## Debugging Commands

### cURL Testing

```bash
# GET request
curl -X GET https://api.example.com/users/123

# GET with authentication
curl -X GET https://api.example.com/users/123 \
  -H "Authorization: Bearer YOUR_TOKEN"

# POST with JSON
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@example.com"}'

# PUT/PATCH
curl -X PATCH https://api.example.com/users/123 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{"name":"Updated Name"}'

# DELETE
curl -X DELETE https://api.example.com/users/123 \
  -H "Authorization: Bearer YOUR_TOKEN"

# Verbose output (see headers)
curl -v https://api.example.com/users

# Save response to file
curl https://api.example.com/users > response.json
```

---

### Browser DevTools

**Network tab:**
1. Open DevTools (F12 or Cmd+Opt+I)
2. Go to Network tab
3. Filter by "XHR" or "Fetch"
4. Click request → Preview/Response/Headers

**What to check:**
- Request URL (correct endpoint?)
- Request headers (auth token present?)
- Request payload (correct data?)
- Response status (2xx, 4xx, 5xx?)
- Response body (error message?)
- Timing (how long did it take?)

---

### JavaScript Console Debugging

```javascript
// Simple fetch with error handling
fetch('https://api.example.com/data')
  .then(response => {
    console.log('Status:', response.status)
    console.log('Headers:', response.headers)
    return response.json()
  })
  .then(data => console.log('Data:', data))
  .catch(error => console.error('Error:', error))

// Async/await with try/catch
async function fetchData() {
  try {
    const response = await fetch('https://api.example.com/data')
    console.log('Status:', response.status)

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`)
    }

    const data = await response.json()
    console.log('Data:', data)
    return data
  } catch (error) {
    console.error('Error:', error.message)
  }
}
```

---

## Time-Saving Patterns

### 5-Minute Debugging Workflow

**Priority order (checks 80% of issues):**

1. **Check HTTP status code** (narrows scope by 80%)
   - 4xx → Client problem
   - 5xx → Server problem
   - No response → Network problem

2. **Look at response body** (error message often clear)
   ```json
   { "error": "Invalid email format" }
   ```

3. **Verify request headers** (authentication, content-type)
   - Authorization header present?
   - Content-Type: application/json?

4. **Use Operation 2 for detailed analysis** (if still stuck)

---

### Common Quick Fixes

| Status | Likely Cause | Quick Fix |
|--------|--------------|-----------|
| **401** | Token expired | Refresh token and retry |
| **403** | Missing permissions | Check user roles |
| **422** | Validation failed | Validate request body |
| **429** | Rate limited | Implement exponential backoff |
| **500** | Server error | Check server logs |
| **502** | Gateway error | Check proxy/load balancer |
| **504** | Timeout | Increase timeout or optimize |
| **CORS** | Missing headers | Configure backend CORS |

---

## Framework-Specific Tools

### React/JavaScript (Axios)

```javascript
// Axios interceptors for global error handling
axios.interceptors.response.use(
  response => response,
  error => {
    console.error('API Error:', {
      status: error.response?.status,
      data: error.response?.data,
      url: error.config?.url
    })
    return Promise.reject(error)
  }
)

// Request with timeout
axios.get('/api/data', {
  timeout: 5000,  // 5 seconds
  headers: {
    'Authorization': `Bearer ${token}`
  }
})
```

---

### Python (Requests)

```python
import requests
import logging

# Enable debug logging
logging.basicConfig(level=logging.DEBUG)

# Make request with error handling
try:
    response = requests.get('https://api.example.com/data')
    response.raise_for_status()  # Raises HTTPError for bad status
    print(f"Status: {response.status_code}")
    print(f"Body: {response.json()}")
except requests.exceptions.HTTPError as e:
    print(f"HTTP Error: {e}")
except requests.exceptions.ConnectionError as e:
    print(f"Connection Error: {e}")
except requests.exceptions.Timeout as e:
    print(f"Timeout: {e}")
except requests.exceptions.RequestException as e:
    print(f"Error: {e}")
```

---

### Node.js (Express)

```javascript
// Global error handler middleware
app.use((err, req, res, next) => {
  console.error('API Error:', {
    method: req.method,
    url: req.url,
    error: err.message,
    stack: err.stack
  })

  res.status(err.status || 500).json({
    error: err.message,
    status: err.status || 500
  })
})

// Async error handling wrapper
const asyncHandler = fn => (req, res, next) => {
  Promise.resolve(fn(req, res, next)).catch(next)
}

// Usage
app.get('/api/data', asyncHandler(async (req, res) => {
  const data = await fetchData()  // Errors caught automatically
  res.json(data)
}))
```

---

## Pro Tips

### ✅ Do

- **Log full request/response** for debugging
  - Include URL, headers, body, status
  - Use structured logging (JSON format)

- **Use API clients** for testing
  - Postman, Insomnia, Thunder Client
  - Save requests for repeat testing
  - Share collections with team

- **Check API documentation** first
  - Expected request format
  - Required headers
  - Authentication method
  - Rate limits

- **Verify environment variables**
  - API keys present?
  - Correct base URLs?
  - Right environment (dev/staging/prod)?

---

### ❌ Don't

- **Assume 200 = success**
  - Some APIs return 200 with error in body
  - Always check response body

- **Ignore error codes**
  - Each code has specific meaning
  - Proper handling improves UX

- **Skip request validation**
  - Validate before sending
  - Saves roundtrip time
  - Better error messages

- **Log sensitive data**
  - Never log tokens, passwords, API keys
  - Redact sensitive fields
  - Use logging levels properly

---

## Debugging Checklist

When API request fails, check in order:

1. **Request basics**
   - [ ] Correct HTTP method (GET, POST, PUT, DELETE)?
   - [ ] Correct URL/endpoint?
   - [ ] Correct protocol (http vs https)?

2. **Headers**
   - [ ] Content-Type header correct?
   - [ ] Authorization header present?
   - [ ] Required custom headers included?

3. **Authentication**
   - [ ] Token/API key valid?
   - [ ] Token not expired?
   - [ ] Token has required scopes/permissions?

4. **Request body**
   - [ ] JSON syntax valid?
   - [ ] All required fields present?
   - [ ] Data types correct (string vs number)?
   - [ ] No extra/unexpected fields?

5. **Network**
   - [ ] Can reach server (ping/curl)?
   - [ ] CORS configured if cross-origin?
   - [ ] Firewall/proxy not blocking?

6. **Response**
   - [ ] Status code makes sense?
   - [ ] Error message clear?
   - [ ] Retry appropriate (429, 503)?

---

## Reference: Status Code Categories

| Range | Category | Action |
|-------|----------|--------|
| **1xx** | Informational | Rarely used |
| **2xx** | Success | Request succeeded |
| **3xx** | Redirection | Follow redirect |
| **4xx** | Client Error | Fix request |
| **5xx** | Server Error | Report to backend |

---

## Reference: Common Headers

| Header | Purpose | Example |
|--------|---------|---------|
| **Authorization** | Authentication | `Bearer eyJhbGc...` |
| **Content-Type** | Request body format | `application/json` |
| **Accept** | Response format | `application/json` |
| **User-Agent** | Client identification | `MyApp/1.0` |
| **X-API-Key** | API key (alternative) | `abc123xyz` |

---

**See [SKILL.md](./SKILL.md) for complete operation details and examples**

---

**Version:** v4.11.0 | **Last Updated:** 2025-12-17
