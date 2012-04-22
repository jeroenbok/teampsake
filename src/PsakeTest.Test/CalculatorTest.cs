using System.Threading;
using NUnit.Framework;

namespace PsakeTest.Test
{
    [TestFixture]
    public class CalculatorTest
    {
        [Test]
        public void Sum()
        {
            Assert.That(new Calculator().Sum(1, 1), Is.EqualTo(2), "sum");
        }

        [Test]
        [Category("Acceptance")]
        public void SumAcceptance()
        {
            Thread.Sleep(2000);
            Assert.That(new Calculator().Sum(10, 10), Is.EqualTo(20), "sum");
        }
    }

    [TestFixture]
    [Category("Acceptance")]
    public class CalculatorAcceptanceTest
    {
        [Test]
        public void Foo()
        {
            
        }

        [Test]
        public void Bar()
        {
            
        }
    }
}
