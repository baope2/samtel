# Azure DevOps

en la imagen 01 se evidencia el flujo del despliegue del front el primer stages realiza el despliegue al ambiente y el segundo stages queda en espera al resultado de las pruebas.

imagen 02 se encuentra la metodologia para su conexion usa un agente para conectarse al bastion y una conexion ssh.

imagen 03 se encuentra el paso a paso que realiza el agente que simplemente es ajecutar el scrpit.

imagen 04 se agrega el uso de autorizacion para ejecutar el release.

iamgen 05 el artefacto se amarra al repositorio y a la rama de integracion para que en el momento que el DEV sube cambios al repositorio se cree el release automaticamente y queda a la espera de las aprobaciones.


