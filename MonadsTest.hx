import Monads;

class MonadsTest {
  static function main() {
    var r = new haxe.unit.TestRunner();
    r.add(new MaybeTest());
    r.run();
  }
}

class MaybeTest extends haxe.unit.TestCase {

  public function testSomething() {
    var m = new Maybe(42);
    assertTrue(switch(m) {
      case Nothing:
        false;
      case Just(x):
        x == 42;
    });
  }

  public function testNothing() {
    var m = new Maybe(null);
    assertTrue(switch(m) {
      case Nothing:
        true;
      case Just(x):
        false;
    });
  }

  public function testBind() {
    var fortyTwo:Maybe<Int> = Just(42);
    var nothing:Maybe<Int> = Nothing;
    var sub = function(b) return function(a) return new Maybe(a - b);
    var obliterate = function(a) return new Maybe(null);
    var result;

    result = fortyTwo.bind(sub(10));
    assertEquals(switch(result) {
      case Nothing: 0;
      case Just(x): x;
    }, 42 - 10);

    result = nothing.bind(sub(10));
    assertTrue(switch(result) {
      case Nothing:
        true;
      case Just(x):
        false;
    });

    result = fortyTwo.bind(obliterate);
    assertTrue(switch(result) {
      case Nothing:
        true;
      case Just(x):
        false;
    });

    result = nothing.bind(obliterate);
    assertTrue(switch(result) {
      case Nothing:
        true;
      case Just(x):
        false;
    });
  }

  public function testFMap() {
    var fortyTwo:Maybe<Int> = Just(42);
    var nothing:Maybe<Int> = Nothing;
    var sub = function(b) return function(a) return a - b;
    var obliterate = function(a) return null;
    var result;

    result = fortyTwo.fmap(sub(10));
    assertEquals(switch(result) {
      case Nothing: 0;
      case Just(x): x;
    }, 42 - 10);

    result = nothing.fmap(sub(10));
    assertTrue(switch(result) {
      case Nothing:
        true;
      case Just(x):
        false;
    });

    result = fortyTwo.fmap(obliterate);
    assertTrue(switch(result) {
      case Nothing:
        true;
      case Just(x):
        false;
    });

    result = nothing.fmap(obliterate);
    assertTrue(switch(result) {
      case Nothing:
        true;
      case Just(x):
        false;
    });
  }

  public function testApply() {
    var fortyTwo:Maybe<Int> = Just(42);
    var nothing:Maybe<Int> = Nothing;
    var sub = function(b) return function(a) return a - b;
    var result;

    result = fortyTwo.apply(Just(sub(10)));
    assertEquals(switch(result) {
      case Nothing: 0;
      case Just(x): x;
    }, 42 - 10);

    result = nothing.apply(Just(sub(10)));
    assertTrue(switch(result) {
      case Nothing:
        true;
      case Just(x):
        false;
    });

    result = fortyTwo.apply(Nothing);
    assertTrue(switch(result) {
      case Nothing:
        true;
      case Just(x):
        false;
    });

    result = nothing.apply(Nothing);
    assertTrue(switch(result) {
      case Nothing:
        true;
      case Just(x):
        false;
    });
  }
}
