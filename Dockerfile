# Etapa 1: Compilación de la solución y sus proyectos
FROM ://microsoft.com AS build
WORKDIR /src

# Copiar el archivo de solución nuevo (.slnx) y los proyectos respetando la estructura
COPY SistemaHB.slnx ./
COPY SistemaHBAPI/SistemaHBAPI.csproj ./SistemaHBAPI/
COPY BibliotecaSistemaHB/BibliotecaSistemaHB.csproj ./BibliotecaSistemaHB/

# Restaurar todas las dependencias usando la nueva solución .slnx
RUN dotnet restore SistemaHB.slnx

# Copiar absolutamente todo el código restante de la solución
COPY . .

# Compilar y publicar la API optimizada para producción
WORKDIR "/src/SistemaHBAPI"
RUN dotnet publish SistemaHBAPI.csproj -c Release -o /app/publish

# Etapa 2: Imagen final ligera para el entorno de ejecución
FROM ://microsoft.com AS final
WORKDIR /app
COPY --from=build /app/publish .

# .NET 10 expone automáticamente el puerto 8080, perfecto para Render
EXPOSE 8080

ENTRYPOINT ["dotnet", "SistemaHBAPI.dll"]
