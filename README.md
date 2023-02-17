# Running ASP.NET Core apps inside of ShinyProxy

Running a asp dotnet core app is very similar to running a [flask application](https://github.com/openanalytics/shinyproxy-flask-demo). There are a few things that need to be considered: 
- You must use the enviorment variable `SCRIPT_NAME` provided by shinyproxy as the path base and use routing.
- Links in the web app may not work correctly unless the base path is acounted for, this can be done with the `@Url.Page` helper.

## What is ShinyProxy? 
[ShinyProxy](https://github.com/openanalytics/shinyproxy) is an open source application proxy for Shiny Apps (and other apps). It is based on [ContainerProxy](https://github.com/openanalytics/containerproxy). Both of which are write by [openanalytics](https://github.com/openanalytics).

## Docker image
The Dockerfile in this repo is provided as a minimal example.  
The docker image can be built in the root of the repository with this command 
```bash
docker build  -t "shinyproxy-aspnet-core-demo" .
```

The app can be run and tested locally with
```bash
docker run -p 8080:8080 shinyproxy-aspnet-core-demo
```

## ShinyProxy Configuration
*Note*: It's mentioned that ShinyProxy 2.6.0 is needed in order to run Flask apps (likely due to `target-path`). I suspect this is the same for dotnet apps but, have not tested this myself.

A full configuration can be found in application.yml. Example ShinyProxy app configuration:

```yaml
specs:
  - id: flask-demo
    container-image: openanalytics/shinyproxy-flask-demo
    port: 8080
    container-env:
      SCRIPT_NAME: "#{proxy.getRuntimeValue('SHINYPROXY_PUBLIC_PATH').replaceFirst('/$','')}"
    target-path: "#{proxy.getRuntimeValue('SHINYPROXY_PUBLIC_PATH')}"
```

## References
- https://github.com/openanalytics/containerproxy
- https://github.com/openanalytics/shinyproxy
- https://github.com/openanalytics/shinyproxy-flask-demo


