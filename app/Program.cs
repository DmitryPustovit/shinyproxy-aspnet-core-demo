var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () =>
{
    return  "Hello World! This is running in Shiny Proxy!"; 
});


app.UseStaticFiles();

// This is critial to ShinyProxy being able to connect properly
app.UsePathBase(new PathString(Environment.GetEnvironmentVariable("SCRIPT_NAME")));
app.UseRouting();

app.Run();
