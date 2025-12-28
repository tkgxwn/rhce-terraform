# RHCE Terraform Project 🚀
Este repositorio contiene la infraestructura como código (IaC) para crear un laboratorio de práctica para el examen RHCE 

Antes de comenzar, asegúrate de tener instalado:

* [Terraform](https://www.terraform.io/downloads.html) (versión 1.0+)
* Este proyecto terraform está diseñado para desplegarse sobre KVM
* Credenciales configuradas en tu entorno local.

## 🛠️ Estructura del Proyecto

| Archivo | Descripción |
| :--- | :--- |
| `main.tf` | Definición principal de los recursos. |
| `variables.tf` | Declaración de variables de entrada. |
| `network-config.yaml` | Configuración de red (Puede cambiar con el hipervisor) |
| `user-data.yaml` | Configuración cloud-init |

## 🚀 Guía de Uso

Sigue estos pasos para desplegar el entorno:


1. ** Ubicate en el directorio que contenga los archivos **
 
   cd */rhce

2.  **Inicializar el proyecto:**

   terraform init
   terraform apply

3. **Destruye proyecto:**
  terraform destroy 
