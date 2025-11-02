using Xunit;
using System.Threading.Tasks;
using FluentAssertions;
using Microsoft.AspNetCore.Mvc.Testing;

namespace SampleApi.Tests;

public class UnitTest1 : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly WebApplicationFactory<Program> _factory;

    public UnitTest1(WebApplicationFactory<Program> factory)
    {
        _factory = factory;
    }

    [Fact]
    public async Task GetRoot_ReturnsHelloMessage()
    {
        var client = _factory.CreateClient();
        var resp = await client.GetAsync("/");
        resp.EnsureSuccessStatusCode();
        var json = await resp.Content.ReadAsStringAsync();
        json.Should().Contain("Hello from SampleApi");
    }
}