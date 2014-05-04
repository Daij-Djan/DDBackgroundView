DDBackgroundView
================

A View (for ios and osx) that can draw all that you ever want in your background: color, gradient, patttern image, just an image, a border, rounded corners... all in one view

**for ios this is convenient** -- not that big a deal because stock UIViews could do it 'easily', but very convenient

    DDBackgroundView *bg = [[DDBackgroundView alloc] initWithFrame:self.view.bounds];
    bg.alpha = 0.9;
    bg.backgroundCornerRadius = 100;
    bg.backgroundColor = [UIColor blueColor];
    bg.backgroundPattern = [UIImage imageNamed:@"pattern"];
    
    CTGradient *g = [CTGradient gradientWithBeginningColor:[UIColor redColor]
                                                endingColor:[UIColor clearColor]];        
    [bg setBackgroundGradient:g withAngle:DDBackgroundViewGradientRadialAngle];
    
    [bg setBackgroundImage:[UIImage imageNamed:@"duck"]
              withAlpha:0.7
             withScaleMode:DDBackgroundViewImageScaleProportionallyDown];
    [bg setBorderColor:[UIColor yellowColor] withWidth:1];

![IOS Screenshot](https://raw.githubusercontent.com/Daij-Djan/DDBackgroundView/master/README_files/ios.png)

for osx, this is also very convenient -- but it's a bigger deal ;) as stuff is a tad harder to do than on ios.

    DDBackgroundView *bg = [[DDBackgroundView alloc] initWithFrame:self.view.bounds];
    bg.alphaValue = 0.99;
    bg.backgroundCornerRadius = 100;
    bg.backgroundColor = [NSColor blueColor];
    bg.backgroundPattern = [NSImage imageNamed:@"pattern"];
    bg.backgroundPatternAlpha = 0.7;
    
    NSGradient *g = [[NSGradient alloc] initWithStartingColor:[[NSColor redColor] colorWithAlpha:0.9] endingColor:[NSColor clearColor]];     
    [bg setBackgroundGradient:g withAngle:DDBackgroundViewGradientRadialAngle];
    
    [bg setBackgroundImage:[NSImage imageNamed:@"duck"]
              withAlpha:0.7
             withScaleMode:DDBackgroundViewImageScaleProportionallUpyDown];
    [bg setBorderColor:[NSColor yellowColor] withWidth:3];

![OSX Screenshot](https://raw.githubusercontent.com/Daij-Djan/DDBackgroundView/master/README_files/osx.png)
