# Connecting to the PostgreSQL Database from Your Desktop

1.  **Ensure Prerequisites:**
    
    -   Install the following tools:
        -   gcloud CLI
        -   Cloud SQL Auth Proxy
        -   psql
    
2.  **Authenticate with GCP:**
```
gcloud auth login
gcloud config set project holomua-doe-demo
``` 
3.  **Grant Necessary Access:** Add your account as a secret accessor (if not already granted):

```
gcloud secrets add-iam-policy-binding belay-dev-postgres-root-password \
    --member="user:your-email@example.com" \
    --role="roles/secretmanager.secretAccessor"
```
    
4.  **Retrieve the PostgreSQL Password:**

```export PGPASSWORD=$(gcloud secrets versions access latest --secret=belay-dev-postgres-root-password)```
    
5.  **Start the Cloud SQL Proxy:** Run the Cloud SQL Auth Proxy to connect to the database:

```cloud-sql-proxy holomua-doe-demo:us-west1:belay-dev --port=5432```

 -  **Connect to the Database:** Open a terminal and use the `psql` command:

```psql -h 127.0.0.1 -p 5432 -U postgres -d belay-dev```    
    
- **Clean Up (Optional):**

  -  Unset the password:
```bash unset PGPASSWORD ```

  -  Stop the proxy: 
```bash CTRL-C to stop the proxy ```
