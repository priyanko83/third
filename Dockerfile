FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "dotnetcorefirst.dll"]



#    Open a command prompt and navigate to your project folder.
#    Use the following commands to build and run your Docker image:
# docker build -t aspnetapp .
# docker run -d -p 8080:80 --name myapp dotnetcorefirst


# View the web page running from a container

#     Go to localhost:8080 to access your app in a web browser.
#     If you are using the Nano Windows Container and have not updated to the Windows Creator Update there is a bug affecting how Windows 10 talks to Containers via “NAT” (Network Address Translation). You must hit the IP of the container directly. You can get the IP address of your container with the following steps:
#         Run the following command and Copy the container ip address and paste into your browser. (For example, 172.16.240.197)
#           docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" myapp


#       Reference: 
#       https://docs.docker.com/engine/examples/dotnetcore/#create-a-dockerfile-for-an-aspnet-core-application