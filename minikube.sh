apiVersion: v1
kind: PersistentVolume
metadata:
  name: strapi-vl
spec:
  storageClassName: manual
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data/strapi"
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: postgres-vl
spec:
  storageClassName: manual
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/mnt/data/postgres"
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: strapi-vl
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgres-vl
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 3Gi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: strapi
  template:
    metadata:
      labels:
        app: strapi
    spec:
      volumes:
      - name: strapi-vl
        persistentVolumeClaim:
          claimName: strapi-vl
      - name: postgres-vl
        persistentVolumeClaim:
          claimName: postgres-vl
      containers:
      - name: postgres
        image: postgres:latest
        env:
        - name: POSTGRES_DB
          value: "strapi"
        - name: POSTGRES_USER
          value: "dreamteam"
        - name: POSTGRES_PASSWORD
          value: "dreamteampasswd"
        ports:
        - containerPort: 5432
          name: postgres
        volumeMounts:
        - name: postgres-vl
          mountPath: /var/lib/postgresql/data
      - name: strapi
        image: dreamteamestiam/backend:latest
        env:
        - name: DATABASE_CLIENT
          value: "postgres"
        - name: DATABASE_HOST
          value: "postgres"
        - name: DATABASE_PORT
          value: "5432"
        - name: DATABASE_NAME
          value: "strapi"
        - name: DATABASE_USERNAME
          value: "dreamteam"
        - name: DATABASE_PASSWORD
          value: "dreamteampasswd"
        - name: NODE_ENV
          value: "production"
        ports:
        - containerPort: 1337
        volumeMounts:
        - name: strapi-vl
          mountPath: /srv/app
      - name: vue
        image: dreamteamestiam/frontend:latest
        env:
        - name: API_URL
          value: "http://strapi.permafrhost.fr:3000"
        ports:
        - containerPort: 3000
---
apiVersion: v1
kind: Service
metadata:
  name: vue
  labels:
    run: vue
spec:
  ports:
  - port: 3000
    protocol: TCP
    targetPort: 3000
  type: LoadBalancer
  selector:
    run: vue
---
apiVersion: v1
kind: Service
metadata:
  name: strapi
  labels:
    run: strapi
spec:
  ports:
  - port: 1337
    protocol: TCP
    targetPort: 1337
  type: LoadBalancer
  selector:
    run: strapi
---
apiVersion: v1
kind: Service
metadata:
  name: postgres
spec:
  ports:
  - port: 5432
  selector:
    app: postgres
