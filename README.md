# Zalando PostgreSQL with Jalali Utils

A PostgreSQL Docker image based on [Zalando Spilo](https://github.com/zalando/spilo) with the [Jalali Utils](https://github.com/teamappir/jalali_utils) extension pre-installed for Persian/Jalali date operations.

## Quick Start

Pull and run the image:

```bash
docker run -d \
  --name postgres-jalali \
  -e POSTGRES_PASSWORD=mypassword \
  -p 5432:5432 \
  ghcr.io/sahra-tech/zalando-pg-jalali:latest
```

## What's Included

- **Base**: Zalando Spilo PostgreSQL 17
- **Extension**: Jalali Utils for Persian calendar operations
- **Features**: All Spilo features (high availability, backup, monitoring)

## Using Jalali Utils

Connect to your database and enable the extension:

```sql
CREATE EXTENSION IF NOT EXISTS jalali_utils;

-- Example: Convert Gregorian to Jalali
SELECT to_jalali('2024-03-20'::date);
-- Result: 1403-01-01

-- Example: Convert Jalali to Gregorian  
SELECT from_jalali(1403, 1, 1);
-- Result: 2024-03-20
```

## Environment Variables

All [Spilo environment variables](https://github.com/zalando/spilo#environment-variables) are supported, including:

- `POSTGRES_PASSWORD`: Database password (required)
- `POSTGRES_USER`: Database username (default: postgres)
- `POSTGRES_DB`: Database name (default: postgres)

## Docker Compose Example

```yaml
version: '3.8'
services:
  postgres:
    image: ghcr.io/sahra-tech/zalando-pg-jalali:latest
    environment:
      POSTGRES_PASSWORD: mypassword
      POSTGRES_DB: myapp
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

## Documentation

- [Jalali Utils Extension](https://github.com/teamappir/jalali_utils)
- [Zalando Spilo Documentation](https://github.com/zalando/spilo)

## License

This image combines:
- Zalando Spilo (Apache 2.0)
- Jalali Utils (Check repository for license)
