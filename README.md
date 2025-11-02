# Azure DevOps Build Pipeline sample: .NET -> Docker -> ACR -> AKS

This sample demonstrates a simple pipeline that:

1. Gets a .NET app from GitHub
2. Restores, builds and runs unit tests
3. Builds a Docker image and pushes it to Azure Container Registry (ACR)
4. Publishes build artifacts (published app and manifests) to Azure Pipelines
5. Provides Kubernetes manifests to deploy the app to AKS

Repository layout:
- src/SampleApi/ : minimal ASP.NET Core app
- tests/SampleApi.Tests/ : xUnit tests
- Dockerfile : builds the app image
- azure-pipelines.yml : Azure DevOps build pipeline
- kubernetes/ : Kubernetes manifests (Deployment + Service)
- scripts/ : optional helper scripts

How to use
1. Create a new GitHub repository and push this project.
2. In Azure DevOps:
   - Create or select a project.
   - Create an Azure Resource Manager service connection (or an ACR service connection) that has permissions to push to your ACR and to manage AKS (or create separate connections).
   - Create a pipeline using `azure-pipelines.yml` from your GitHub repo.
   - Add pipeline variables:
     - `acrLoginServer` - your ACR login server (e.g. myregistry.azurecr.io)
     - `acrServiceConnection` - the name of the service connection for ACR (if using Docker@2 task)
   - Run the pipeline.
3. Create a Release pipeline (or multi-stage YAML) that consumes the artifact published by the build and deploys the `kubernetes/deployment.yaml` (replace image reference).
   - Use the manifest or kubectl tasks in Azure DevOps and point kubectl to your AKS cluster using a service connection.

Notes
- Replace placeholders in the YAML and Kubernetes manifests: `<YOUR_ACR_LOGIN_SERVER>`, `<IMAGE_TAG>` or set them as pipeline variables.
- You will need an ACR and AKS cluster in Azure and an Azure service connection in Azure DevOps.