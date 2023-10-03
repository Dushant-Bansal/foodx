String? Function(String?)? nullValidation(String error) {
  return (value) {
    if (value == null || value.isEmpty) return error;
    return null;
  };
}
