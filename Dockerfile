FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
COPY . .
EXPOSE 8080
ENTRYPOINT ["dotnet", "SistemaHBAPI.dll"]
