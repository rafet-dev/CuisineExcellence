# ---------- Étape build ----------
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Restauration des packages (cache Docker : ne refait que si le csproj change)
COPY GC_MVC/GC_MVC.csproj ./GC_MVC/
RUN dotnet restore ./GC_MVC/GC_MVC.csproj

# Copie du code et publication
COPY GC_MVC/ ./GC_MVC/
RUN dotnet publish ./GC_MVC/GC_MVC.csproj \
    -c Release \
    -o /app/publish \
    --no-restore

# ---------- Étape runtime ----------
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish ./

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "GC_MVC.dll"]
