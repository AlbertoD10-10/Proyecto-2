# ST0263: Proyecto 2 - Cluster Kubernetes

## Descripción del Proyecto

Este proyecto tiene como objetivo desplegar una aplicación web monolítica en un clúster Kubernetes de alta disponibilidad utilizando la distribución MicroK8s en máquinas virtuales configuradas en la nube (AWS IaaS). La aplicación cuenta con una base de datos de alta disponibilidad y un sistema de archivos externo gestionado mediante un servidor NFS.

## Objetivo

Desplegar la aplicación en un clúster Kubernetes en múltiples máquinas virtuales en AWS, garantizando alta disponibilidad en las capas de aplicación, base de datos y almacenamiento.

# Info de la materia: C2466-ST0263-1586 - Tópicos Especiales en Telemática

## Estudiantes:
- Alberto Andres Diaz Mejia aadiazm@eafit.edu.co
- Andres Felipe Rua Ortega , afruao@eafit.edu.co
- Moises David Arrieta Hernandez, mdarrietah@eafit.edu.co
- Diego Alexander Munera Tobon, damunerat@eafit.edu.co
- Holmer Ortega Gomez, hortegag@eafit.edu.co
## Profesor: 
 Edwin Montoya, emontoya@eafit.edu.co
## Video sustentación
https://youtu.be/5J_7lKF5lmk?si=Q2Pwrg4wp6a-ndnB
## Guía paso a paso
Para acceder al archivo, es necesario darle click al siguiente link: 
[Acceder al archivo Guía Paso A Paso.md](https://github.com/AlbertoD10-10/Proyecto-2/blob/main/Guia%20Paso%20A%20Paso)
## Referencias
- [Instalar MicroK8s](https://microk8s.io/#install-microk8s)
- [Utilice NFS para volúmenes persistentes en MicroK8](https://microk8s.io/docs/how-to-nfs)
- [Implementación de MySQL en Kubernetes](https://medium.com/@midejoseph24/deploying-mysql-on-kubernetes-16758a42a746)

## Requisitos

1. **Alta Disponibilidad**:
   - La aplicación debe ser tolerante a fallos en los nodos de Kubernetes.
   - La base de datos debe desplegarse con un sistema de replicación o alta disponibilidad.
   - Almacenamiento compartido a través de NFS para los servicios con estado.

2. **Escalabilidad**:
   - El clúster debe permitir el aumento dinámico de nodos, preferiblemente de forma automática.
   - Configuración de un dominio propio para la aplicación (https://proyecto2.dominio.tld).

3. **Balanceo de Carga**:
   - Utilizar un balanceador para distribuir el tráfico entre los servicios en el clúster.

## Instructivo Paso a Paso

### 1. Creación y Configuración Inicial de Instancias en AWS

- **Crear 4 máquinas virtuales** en AWS con Ubuntu y 20 GB de almacenamiento:
  - `microk8s-master`: Nodo maestro del clúster.
  - `microk8s-worker-1` y `microk8s-worker-2`: Nodos de trabajo.
  - `microk8s-nfs`: Servidor NFS para almacenamiento compartido.
- Habilitar conexiones HTTP, HTTPS, y verificar configuraciones del balanceador.

### 2. Configuración del Nodo Maestro (microk8s-master)

1. Conéctese por SSH a la instancia `microk8s-master`.
2. Actualice el sistema:
   ```bash
   sudo apt update
   ```
3. Instale MicroK8s:
   ```bash
   sudo snap install microk8s --classic

   ```

4. Verifique el estado de MicroK8s:
   ```bash
   microk8s status --wait-ready
   ```

5. configure el usuario
   ```bash
   sudo usermod -a -G microk8s $USER
   mkdir -p ~/.kube
   sudo chown -R $USER ~/.kube
   ```

6. Habilite los plugins de MicroK8s necesarios:
   ```bash
   microk8s enable dashboard dns registry istio ingress
   ```
### 3. Configuración de Nodos Worker

Repita los pasos de instalación en las instancias microk8s-worker-1 y microk8s-worker-2, siguiendo el mismo procedimiento del nodo maestro.

### 4. Configuración del Servidor NFS (microk8s-nfs)

1. Conéctese a microk8s-nfs y configure el servidor NFS:
   ```bash
   sudo apt update
   sudo apt install nfs-kernel-server
   sudo mkdir -p /mnt/wordpress
   sudo chown nobody:nogroup /mnt/wordpress
   sudo chmod 777 /mnt/wordpress
   ```
2. Edite el archivo /etc/exports y agregue:
   ```bash
   /mnt/wordpress *(rw,sync,no_subtree_check)
   ```
3. Reinicie el servicio NFS:
   ```bash
   sudo systemctl restart nfs-kernel-server
   ```

### 5. Creación del Clúster Kubernetes

1. En microk8s-master, ejecute:
   
