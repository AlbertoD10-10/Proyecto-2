# Proyecto de Configuración de Clúster Kubernetes en GCP con NFS y WordPress

Este proyecto describe cómo configurar un clúster de Kubernetes en Google Cloud Platform (GCP) con almacenamiento persistente utilizando NFS, y desplegar WordPress junto con su base de datos MySQL en el clúster.

## Requisitos Previos

- **Cuenta en Google Cloud Platform (GCP)**.
- **Instalación de herramientas**:
  - `gcloud` CLI (Google Cloud SDK).
  - `kubectl` CLI.
  - **Helm 3** para gestionar Kubernetes charts.
  - **SSH** para conectarse a las instancias de VM.

## Pasos de Configuración

### 1. Creación y Configuración Inicial de Instancias en GCP

1. Crear 4 máquinas virtuales (VMs) en GCP con Ubuntu 20.04 LTS y 20 GB de almacenamiento. Nombres de las VMs:
   - `microk8s-master`
   - `microk8s-worker-1`
   - `microk8s-worker-2`
   - `microk8s-nfs`
   
2. Asegurarse de que las VMs tengan acceso a HTTP y HTTPS, y verificar el balanceador de carga de GCP.

### 2. Configuración de la Instancia Master

1. Conéctate a `microk8s-master` vía SSH y ejecuta los siguientes comandos para instalar MicroK8s:

   ```bash
   sudo apt update && sudo apt upgrade -y
   sudo snap install microk8s --classic
   sudo microk8s enable dns dashboard registry istio

## Configura kubectl para usar MicroK8s como tu cliente Kubernetes:

```bash
alias kubectl="microk8s kubectl"
```

## 3. Configuración de las Instancias Worker
### 1. Conéctate a microk8s-worker-1 y microk8s-worker-2 vía SSH. En ambas instancias, ejecuta los mismos pasos de instalación de MicroK8s.

```bash
sudo apt update && sudo apt upgrade -y
sudo snap install microk8s --classic
sudo microk8s enable dns
```

### 2. En la instancia microk8s-master, ejecuta el siguiente comando para obtener el comando de unión para los workers:

```bash
microk8s add-node
```

### 3. Conéctate a las instancias worker y ejecuta el comando proporcionado por add-node para unirlas al clúster.

### 4. Verifica que los nodos estén activos:

```bash
kubectl get nodes
```

## 4. Configuración de NFS
### 1. Conéctate a microk8s-nfs vía SSH. Instala NFS y configura un directorio para compartir:

```bash
sudo apt update
sudo apt install nfs-kernel-server
sudo mkdir -p /mnt/wordpress
```

### 2. Configura el directorio a compartir en /etc/exports:

```bash
/mnt/wordpress *(rw,sync,no_subtree_check)
```

### 3. Reinicia el servicio NFS:

```bash
sudo systemctl restart nfs-kernel-server
```

## 5. Instalación del Driver NFS en Kubernetes


### 1. En microk8s-master, habilita Helm3 y añade el repositorio para el CSI Driver de NFS:

```bash
helm repo add nfs-provisioner https://charts.nfs-provisioner.io
helm repo update
```

### 2. Instala el driver de NFS:

```bash
helm install nfs-provisioner nfs-provisioner/nfs-provisioner
```


### 3. Crea el StorageClass para NFS:

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: nfs
provisioner: kubernetes.io/nfs
```


### 4. Crea el PersistentVolumeClaim (PVC) para NFS.

## 6. Despliegue de WordPress y Base de Datos

### 1. Crea un archivo mysql-secret.yaml para almacenar la contraseña de MySQL.

### 2. Crea los archivos YAML para los PersistentVolumes (PV) y PersistentVolumeClaims (PVC) para MySQL y WordPress:
- mysql-pv-pvc.yaml
- wordpress-pv-pvc.yaml

### Crea y aplica los archivos de Deployment y Service para MySQL y WordPress. Un ejemplo de configuración para MySQL:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:5.7
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: password
        volumeMounts:
        - name: mysql-data
          mountPath: /var/lib/mysql
```

### 4. Despliega WordPress con el archivo de configuración de Deployment y Service correspondiente.

## 7. Acceso a WordPress

### 1. Configura un LoadBalancer para el servicio de WordPress para acceder a la interfaz web desde un navegador.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: wordpress
spec:
  selector:
    app: wordpress
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
```
## 8. Verificación

### 1. Asegúrate de que todos los pods estén corriendo correctamente:

```bash
kubectl get pods
```

### 2. Accede a la IP pública proporcionada por el LoadBalancer para verificar que WordPress esté corriendo correctamente.

## Conclusión

### Este proyecto establece un clúster de Kubernetes en GCP, configurando almacenamiento persistente a través de NFS, y desplegando WordPress y su base de datos MySQL en el clúster.

