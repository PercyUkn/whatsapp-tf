# Instrucciones

- Crear un archivo terraform.tfvars para suministrar las variables de entorno.
- Aplicar la configuración:

```
  terraform apply -var-file="terraform.tfvars" -auto-approve
```
- Se tendrán como ouputs:
  - whatsapp_lambda_repo_url: URL del repositorio de la lambda del webhook de whatsapp
  - whatsapp_server_repo_url: URL del repositorio de whatsapp-server desplegado en ECS
  - whatsapp_server_lb_url: DNS del load balancer creado para whatsapp-server

- Crear una URL pública para la lambda
- Realizar la configuración respectiva del webhook en la app de Meta. 

## Variables de entorno

| Variable                    | Description                                         |
|-----------------------------|-----------------------------------------------------|
| aws_access_key_id           | AWS access key ID usada por el Docker de Codebuild  |
| aws_secret_access_key       | AWS secret access key por el Docker de Codebuild    |
| email_subscriber            | Correo del suscriptor de SNS para el envío del QR   |
| load_balancer_vpc_id        | ID de la VPC dónde se hará el despliegue            |
| imgur_client_id             | ID del cliente de IMGUR para subir QR's             |
| meta_id_number              | ID del número de la app de Meta                     |
| meta_token                  | Token permanente de la app de Meta                  |
| webhook_token               | Token para registrar un webhook con Meta            |
| cantidad_clientes_iniciales | Cantidad de clientes iniciales para whatsapp-web.js |
