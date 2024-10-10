# Scripts

estos scripts estan diseñados para realizar el despligue automatizados de la aplicacion y6 cuenta tambien con un rollback en caso de que se necesite

en los scprits econtraran el paso a paso de como se clona el repo repositorio, se crea la imagen de docker, se tagea la imagen y se sube a un ECR de AWS

hasta la aplicacion de la nueva imagen directamente en el deployment.yml de manera automatica

el control de la version se realiza por medio de variables las cuales van llevando el conteo de las imagenes creadas.


