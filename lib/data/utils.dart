extension QueryParameterAdd on Map {
  addParam(key, value) {
    if (value != null) {
      this[key] = value;
    }
  }
}