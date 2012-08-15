#import "GPUImageMirrorFilter.h"

NSString *const kGPUImageMirrorFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 
 uniform highp float division;
 uniform int mode;
 
 void main()
{
	if(mode == 0) {
		// Bypass
		gl_FragColor = texture2D(inputImageTexture, textureCoordinate);
	} else if(mode == 1) {
		// Horizontal Mirror, Favor Left
		if(textureCoordinate.x > division) {
			highp vec2 samplePos = vec2((division * 2.0) - textureCoordinate.x, textureCoordinate.y);
			gl_FragColor = texture2D(inputImageTexture, samplePos);
		} else {
			gl_FragColor = texture2D(inputImageTexture, textureCoordinate);
		}
	} else if(mode == 2) {
		// Horizontal Mirror, Favor Right
		if(textureCoordinate.x < division) {
			highp vec2 samplePos = vec2((division * 2.0) - textureCoordinate.x, textureCoordinate.y);
			gl_FragColor = texture2D(inputImageTexture, samplePos);
		} else {
			gl_FragColor = texture2D(inputImageTexture, textureCoordinate);
		}
	} else if(mode == 3) {
		// Vertical Mirror, Favor Top
		if(textureCoordinate.y > division) {
			highp vec2 samplePos = vec2(textureCoordinate.x, (division * 2.0) - textureCoordinate.y);
			gl_FragColor = texture2D(inputImageTexture, samplePos);
		} else {
			gl_FragColor = texture2D(inputImageTexture, textureCoordinate);
		}
	} else if(mode ==4) {
		// Vertical Mirror, Favor Bottom
		if(textureCoordinate.y < division) {
			highp vec2 samplePos = vec2(textureCoordinate.x, (division * 2.0) - textureCoordinate.y);
			gl_FragColor = texture2D(inputImageTexture, samplePos);
		} else {
			gl_FragColor = texture2D(inputImageTexture, textureCoordinate);
		}
	} else if(mode == 5) {
		// Diagonal, Favor Top-Left
		
	} else if(mode == 6) {
		// Diagonal, Favor Top-Right
		
	} else if(mode == 7) {
		// Diagonal, Favor Bottom-Left
		
	} else if(mode == 8) {
		// Diagonal, Favor Bottom-Right
	
	}
	
}
);


@implementation GPUImageMirrorFilter
@synthesize mode = _mode;
@synthesize division = _division;

#pragma mark -
#pragma mark Initialization and teardown

-(id) init {
    if(! (self = [super initWithFragmentShaderFromString:kGPUImageMirrorFragmentShaderString]) ){
        return nil;
    }
    
    modeUniform = [filterProgram uniformIndex:@"mode"];
	divisionUniform = [filterProgram uniformIndex:@"division"];

	[self setMode:MIRROR_MODE_NONE];
	[self setDivision:0.5];
	
    return self;
}

#pragma mark -
#pragma mark Accessors

-(void) setDivision:(float)division {
	_division = division;
	[self setFloat:_division forUniform:divisionUniform program:filterProgram];
}

-(void) setMode:(GLuint)mode {
    _mode  = mode;
	[self setInteger:_mode forUniform:modeUniform program:filterProgram];
}

@end
