#import "GPUImageFilter.h"

typedef enum mirrorModes {
	MIRROR_MODE_NONE = 0,
	MIRROR_MODE_HORIZ_LEFT = 1,
	MIRROR_MODE_HORIZ_RIGHT = 2,
	MIRROR_MODE_VERT_TOP = 3,
	MIRROR_MODE_VERT_BOTTOM = 4,
	MIRROR_MODE_DIAG_TL = 5,
	MIRROR_MODE_DIAG_TR = 6,
	MIRROR_MODE_DIAG_BL = 7,
	MIRROR_MODE_DIAG_BR = 8
} mirrorModes;

@interface GPUImageMirrorFilter : GPUImageFilter
{
    GLint modeUniform;
	GLfloat divisionUniform;
    
}
@property (nonatomic, readwrite) GLuint mode;
@property (nonatomic, readwrite) float division;

@end