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
		}
			
	}
);


@implementation GPUImageMirrorFilter
@synthesize mode, division;

-(id) init {
    if(! (self = [super initWithFragmentShaderFromString:kGPUImageMirrorFragmentShaderString]) ){
        return nil;
    }
    
    modeUniform = [filterProgram uniformIndex:@"mode"];
	divisionUniform = [filterProgram uniformIndex:@"division"];
    self.mode = MIRROR_MODE_NONE;
    self.division = 0.5;
    return self;
}

-(void) setDivision:(float) newDivision {
	division = newDivision;
	[GPUImageOpenGLESContext useImageProcessingContext];
    [filterProgram use];
    glUniform1f(divisionUniform, division);
}

-(void) setMode:(int)newMode {
    mode  = newMode;
    [GPUImageOpenGLESContext useImageProcessingContext];
    [filterProgram use];
    glUniform1i(modeUniform, mode);
}


@end
