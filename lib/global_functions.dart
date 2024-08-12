String getAttached(String? value){
  if(value=="Near Me")return 'street';
  if(value=="Within my city")return 'city';
  if(value=="Within my District")return 'district';
  if(value=="Within my Region")return 'region';
  if(value=="All of Ghana")return 'country';
  return '';
}