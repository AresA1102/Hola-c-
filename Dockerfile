# 1) Imagen base SDK 9.0
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# 2) Clonar repositorio
RUN apt-get update && apt-get install -y git \
 && git clone https://github.com/AresA1102/Hola-c-.git

# 3) Cambiar al directorio del proyecto
WORKDIR /src/Hola-c-

# 4) Restaurar y compilar
RUN dotnet restore
RUN dotnet publish -c Release -o /app --framework net9.0

# 5) Imagen runtime
FROM mcr.microsoft.com/dotnet/runtime:9.0
WORKDIR /app
COPY --from=build /app .

ENTRYPOINT ["dotnet", "Hola-c#.dll"]

