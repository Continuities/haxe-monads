private enum MaybeEnum<A> {
  Nothing;
  Just(a:A);
}
abstract Maybe<A>(MaybeEnum<A>) from MaybeEnum<A> to MaybeEnum<A> {
  public inline function new(value:Null<A>) {
    this = value == null ? Nothing : Just(value);
  }
  public inline function bind<B>(func:A -> Maybe<B>):Maybe<B> {
    return switch(this) {
      case Nothing:
        return Nothing;
      case Just(a):
        return func(a);
    }
  }
  public inline function fmap<B>(func:A -> B):Maybe<B> {
    return bind(function(a) return new Maybe(func(a)));
  }
  public inline function apply<B>(func:Maybe<A -> B>):Maybe<B> {
    return switch(func) {
      case Nothing:
        return Nothing;
      case Just(f):
        return fmap(f);
    }
  }
}
