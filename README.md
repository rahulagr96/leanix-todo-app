# Microservice Deployment on Azure with Java and Terraform

This project demonstrates how to set up a basic Java microservice that provides a health check and a CRUD interface for managing ToDo items. It includes provisioning an Azure SQL Database and hosting the application on Azure App Service using Terraform. The deployment process is automated with GitHub Actions.

## Project Structure

``` bash
project
│   README.md
│   
└───.github
│     ├── workflows
│         ├── app-release.yml
│         ├── infra-app-destroy.yml
│         ├── infra-app.yml
│         └── infra-init.yml
│         └── infra-test.yml
├── terraform
│   ├── infra-app
│   │   ├── database.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── versions.tf
│   │   └── webapp.tf
│   └── infra-init
│       ├── main.tf
│       ├── variables.tf
│       └── versions.tf
├── microservices
```

- `microservice/src/`: Java source files for the microservice.
- `microservice/pom.xml`: Build configuration files for Maven or Gradle.
- `.github/workflows/`: CI/CD pipeline definitions for GitHub Actions.
- `terraform/`: Terraform configuration files for provisioning Azure resources.

## How to execute on Azure?

- Start `infra-init.yml` pipeline
- Start `infra-app.yml` pipeline to create the desired environment
- Start `todo-release-prd` pipeline to build and deploy the application.
- Test the app's CRUD operation using curl (refer to the `infra-test.yml` pipeline).

## Pipelines

1. `infra-init`  
   - **Triggers:** manual
   - Creates a `leanixgeneric-rg` resource group and contains a storage account that stores all `tfstate` files (multiple environments)
2. `infra-app`
   - **Triggers:** manual
   - Creates an environment specific resource group, that contains a `web_app` and `mssql_server` with a database.
3. `infra-app-destroy`
   - **Triggers:** manual
   - Destroys an environment using terraform.
4. `todo-release-prd`
   - **Triggers:** push(main)
   - builds the microservice
   - deploys the microservice in `prd` env
5. `todo-manual-deploy`
   - **Triggers:** manual
   - builds the microservice
   - deploys the microservice on any env
6. `infra-test`
   - Performs CRUD operation to test the application

## Prerequisites

- Java JDK 11 or newer
- Maven (if using `pom.xml`)
- An Azure account with an active subscription
- Terraform installed on your local machine

## Local Development Setup
`lets create a prd environment`

1. Create an Azure Account
2. Create a role assignment
3. Perform `az login`
4. Clone the repository:

   ``` bash
   git clone https://github.com/rahulagr96/leanix-java-microservice.git
   ```

5. Run `infra-init`
6. Run `infra-app`
   1. terraform init -backend-config="key=prd-terraform.tfstate"
   2. terraform plan
   3. terraform plan -out tfplan -var env=prd -var administrator_login=`${{ new db username }}` -var administrator_login_password=`${{ new db password }}`

7. Update the `microservices/src/main/resources/application.properties` by adding these below lines:
   - spring.datasource.url=$JDBC_URL
   - username=$AZURE_DB_LOGIN_ID@leanix-`prd`-sql
   - spring.datasource.password=$AZURE_DB_LOGIN_PASS
8. Run the spring boot app using `mvn spring-boot:run`
9. Test the app's CRUD operation using curl (refer to the `infra-test.yml` pipeline).
10. Check the changes in azure db

## Reasons for Choosing the Described Architecture
Choosing this architecture has several advantages:

1. **Modularization**: The use of modules, such as the "naming" module, allows for better organization and abstraction of resources. This promotes reusability and maintainability of Terraform configurations.

2. **Consistent Naming**: The "naming" module ensures consistent naming conventions across resources, which enhances readability and understanding of the infrastructure. It also reduces the chances of naming conflicts.

3. **Automation**:
  The use of GitHub Actions for CI/CD and Terraform for infrastructure as code allows for automation of the deployment process.
  This reduces manual intervention, minimizes errors, and speeds up the deployment cycle, leading to faster time-to-market for new features and updates.

4. **Resource Group**: Grouping resources within a resource group provides logical isolation, simplifies management, and enables easier resource governance and access control.

5. **Azure Storage for Terraform State**: Storing Terraform state files in Azure Blob Storage provides a centralized location for managing state, which enhances collaboration among team members. It also enables state locking, versioning, and encryption, ensuring the security and integrity of infrastructure changes.

6. **Azure App Service Plan and Web App**: Utilizing Azure App Service for hosting the web application offers scalability, reliability, and built-in DevOps capabilities. The Free tier service plan is suitable for development and testing purposes, while Linux-based web apps offer flexibility and compatibility with various application stacks.

7. **Azure SQL Database**: Leveraging Azure SQL Database for data storage ensures high availability, scalability, and security of the database. The Basic tier provides cost-effective performance for small-scale applications, while the License Included model simplifies licensing management.

8. **Maintainability**:
  The use of infrastructure as code (Terraform) and version control (GitHub) simplifies the management and maintenance of the deployment environment.
  Changes to infrastructure can be tracked, reviewed, and rolled back if necessary, ensuring a stable and manageable deployment.

1. **Future-Proofing**:
  By leveraging cloud-native services like Azure App Service and Azure SQL Database, the architecture is designed to accommodate future enhancements and scale as the application grows.
  The use of GitHub Actions enables easy integration with additional CI/CD tools or processes as needed.

## Future Implementation:

1. **Dockerise the Application**:
   - Dockerizing the application would enable the creation of lightweight, portable containers that encapsulate the application code and dependencies. This approach offers consistency across development, testing, and production environments, as the same container image can be deployed anywhere Docker is installed.

2. **Make the Database Authentication Passwordless**:
   - Removing the need for database authentication credentials (username and password) can improve security by eliminating the risk of credential exposure and simplifying management, especially in automated deployment pipelines.
