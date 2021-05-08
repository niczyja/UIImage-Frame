
# UIImage+Frame

Extension (in Swift) and Category (in Obj-C) on UIImage with function that returns image frame in UIImageView based on current content mode. Playgound to play around included.

Supports all `UIView.ContentMode`s.
## Usage/Examples

Swift:

```
let image = UIImage(named: "my-image")
let imageView = UIImageView(image: image)

let frame = image.frame(in: imageView)
```

Obj-C:

```
UIImage *image = [UIImage imageNamed:@"my-image"];
UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
CGRect frame = [image frameInView:imageView];
```

## Screenshots

![Playground](http://niczyja.pl/projekty/shots/UIImage+Frame.png)

  
## License

[MIT](https://github.com/niczyja/UIImage-Frame/blob/master/LICENSE)

  