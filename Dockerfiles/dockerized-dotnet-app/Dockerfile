# Etapa de construcción
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copia y restaura dependencias
COPY dockerized-dotnet-app.csproj .
RUN dotnet restore

# Copia el resto del código y compila la aplicación
COPY . .
RUN dotnet publish -c Release -o /out

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /out .

# Expone el puerto en el que la aplicación escucha
EXPOSE 80

# Comando para iniciar la aplicación
ENTRYPOINT ["dotnet", "dockerized-dotnet-app.dll"]
