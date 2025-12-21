# Project Memory - Team Collaboration API

**Last Updated:** 2025-12-21
**Version:** 1.0.0

---

## What Does This Application Do?

This API powers a team collaboration platform for remote workers. It handles user management, post creation/editing, and sends SMS notifications for urgent tasks.

**Core Features:**
- User registration and authentication
- Post creation and management (team updates, announcements)
- SMS notifications via Twilio (urgent task alerts)

**Target Users:** Remote engineering teams (10-50 people per workspace)

---

## Tech Stack

**Primary Technologies:**
- **Node.js** (v16+) - Runtime
- **Express** (v4.18) - REST API framework
- **MongoDB** - Database (users, posts)
- **JWT** - Token-based authentication

**External Services:**
- **Twilio SMS API** - Send urgent task notifications
  - Triggered: When task priority = "urgent" and user has SMS enabled
  - Rate limit: 100 SMS/day (free tier)

---

## API Endpoints

### Users (`/api/users`)
- `GET /api/users` - List all users
- `POST /api/users` - Create new user (sends welcome SMS)

### Posts (`/api/posts`)
- `GET /api/posts` - List all posts
- `POST /api/posts` - Create new post

### Authentication (`/api/auth`)
- `POST /api/auth/login` - Login with JWT token response

---

## File Structure

```
project/
├── server.js           # Express server setup
├── routes/             # API endpoint definitions
│   ├── users.js       # User endpoints
│   ├── posts.js       # Post endpoints
│   └── auth.js        # Authentication
├── services/           # Business logic
│   └── twilio.js      # SMS notification service
└── package.json       # Dependencies
```

---

## External Services & APIs

### Twilio SMS Integration
**Purpose:** Send urgent task notifications

**When triggered:**
- User creates task with priority="urgent"
- Task assigned user has SMS notifications enabled
- Within daily SMS limit (100/day on free tier)

**Environment variables required:**
- `TWILIO_SID` - Account SID
- `TWILIO_TOKEN` - Auth token
- `TWILIO_NUMBER` - Sender phone number

---

## Common Commands

### Development
```bash
npm run dev      # Start with nodemon (auto-reload)
npm start        # Start production server
npm test         # Run test suite
```

---

## Important Notes for Claude

**When modifying this codebase:**
- JWT tokens are used (not sessions)
- Twilio SMS has rate limits (100/day) - don't send in loops
- MongoDB connection string in .env (not committed)
- All routes require authentication except /auth/login
