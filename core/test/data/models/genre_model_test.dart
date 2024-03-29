
import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/movie/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  const genreModel = GenreModel(
      id: 1,
      name: 'name'
  );
  const genre = Genre(
      id: 1,
      name: 'name'
  );


  test('should be a subclass of genre entity', () async {
    final result = genreModel.toEntity();
    expect(result, genre);
  });

}