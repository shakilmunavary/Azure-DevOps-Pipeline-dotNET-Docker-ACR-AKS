# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# copy csproj and restore
COPY src/SampleApi/*.csproj ./src/SampleApi/
RUN dotnet restore src/SampleApi/SampleApi.csproj

# copy everything else and build
COPY . .
RUN dotnet publish src/SampleApi/SampleApi.csproj -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80
ENTRYPOINT ["dotnet", "SampleApi.dll"]