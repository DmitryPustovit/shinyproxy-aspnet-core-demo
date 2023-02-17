# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# copy csproj and restore as distinct layers
COPY *.sln .    
COPY app/*.csproj ./app/
RUN dotnet restore app/

# copy everything else and build app
COPY app/. ./app/
WORKDIR /app
RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./
EXPOSE 8080
ENTRYPOINT ["dotnet", "app.dll", "--urls", "http://0.0.0.0:8080"]