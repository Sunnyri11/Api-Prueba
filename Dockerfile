FROM ://microsoft.com AS final
WORKDIR /app
COPY . .
EXPOSE 8080
ENTRYPOINT ["dotnet", "SistemaHBAPI.dll"]
