# Learn about building .NET container images:
# https://github.com/dotnet/dotnet-docker/blob/main/samples/README.md
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY DockerTestApp/*.csproj .
RUN dotnet restore --use-current-runtime  

# copy everything else and build app
COPY DockerTestApp/. .
RUN dotnet publish -c Release -o out


# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "DockerTestApp.dll"]
