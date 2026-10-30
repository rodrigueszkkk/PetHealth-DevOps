using System.Net;
using Xunit;

namespace PetHealthEcosystem.Tests.Integration.Controllers
{
    [Collection("Pets API collection")]
    public class WellcomeEndpointIntegrationTests
    {
        private readonly HttpClient _client;

        public WellcomeEndpointIntegrationTests(CustomWebApplicationFactory factory)
        {
            _client = factory.CreateClient();
        }

        [Fact]
        public async Task Wellcome_DeveRetornarOkComMensagem()
        {
            // Act
            var response = await _client.GetAsync("/wellcome");

            // Assert
            Assert.Equal(HttpStatusCode.OK, response.StatusCode);
            var body = await response.Content.ReadAsStringAsync();
            Assert.False(string.IsNullOrWhiteSpace(body));
        }

        [Fact]
        public async Task Swagger_DeveEstarDisponivel()
        {
            // Act
            var response = await _client.GetAsync("/swagger/v1/swagger.json");

            // Assert
            Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        }
    }
}
