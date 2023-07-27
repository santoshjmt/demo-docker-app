FROM mcr.microsoft.com/dotnet/sdk:7.0 AS base  
WORKDIR /app  
EXPOSE 80  
EXPOSE 443  
  
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build  
WORKDIR /src  
COPY . demo-docker-app/  
RUN dotnet restore "demo-docker-app/DockerTestApp.csproj"  
COPY . .  
WORKDIR "/src/DockerTestApp"  
RUN dotnet build "DockerTestApp.csproj" -c Release -o /app/build  
  
FROM build AS publish  
RUN dotnet publish "DockerTestApp.csproj" -c Release -o /app/publish  
  
FROM base AS final  
WORKDIR /app  
COPY --from=publish /app/publish .  
ENTRYPOINT ["dotnet", "DockerTestApp.dll"]