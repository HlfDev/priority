enum AlertPriority {
  error(2),
  warning(1),
  info(0);

  const AlertPriority(this.value);
  final int value;
}
