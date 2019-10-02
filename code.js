if (j<slices) {
  float min = slices+1;
  for (int i = j; i<imageIndex.size(); ++i) {
    if (imageIndex.get(i) < min) { 
      min = imageIndex.get(i); 
      s = i;
    }
  }
  th = imageIndex.get(j); 
  imageIndex.set(j, int(min));
  imageIndex.set(s, int(th));
  j++
  