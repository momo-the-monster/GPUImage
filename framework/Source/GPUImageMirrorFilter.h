#import "GPUImageFilter.h"

typedef enum mirrorModes {
	MIRROR_MODE_HORIZ_LEFT = 0,
	MIRROR_MODE_HORIZ_RIGHT = 1,
	MIRROR_MODE_VERT_TOP = 2,
	MIRROR_MODE_VERT_BOTTOM = 3
} mirrorModes;

@interface GPUImageMirrorFilter : GPUImageFilter
{
    GLint modeUniform;
	GLfloat divisionUniform;
    
}
@property (nonatomic, readwrite) int mode;
@property (nonatomic, readwrite) float division;

@end
