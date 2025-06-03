# TDL SDK C Interface Documentation

**Version:** 2.0  
**Release Date:** March 31, 2025  
**Copyright:** ©2025 Beijing Crystal Vision Intelligence Technology Co., Ltd.  
**Translated:** with Claude 4 by Platima 2025-06-02  
**Source:** [TDLSDKSoftwareDevelopmentGuide_zh.pdf](https://doc.sophgo.com/cvitek-develop-docs/master/docs_latest_release/CV180x_CV181x/zh/01.software/TPU/TDL_SDK_Software_Development_Guide/build/TDLSDKSoftwareDevelopmentGuide_zh.pdf)

---

## Table of Contents

1. [Model List](#1-model-list)
2. [Structure Reference](#2-structure-reference)
3. [API Reference](#3-api-reference)

---

## Revision History

| Date | Description | Owner |
|------|-------------|-------|
| 2025/03/28 | Initial draft | Zhang Siyi |
| 2025/03/31 | Added API definitions | Liu Junfei |
| 2025/04/02 | Added model list and structure definitions | Zheng Xinye |

---

## 1. Model List

| Model Name | Description |
|------------|-------------|
| TDL_MODEL_MBV2_DET_PERSON | Human body detection model |
| TDL_MODEL_YOLOV5_DET_COCO80 | YOLOv5 COCO80 detection model |
| TDL_MODEL_YOLOV8_DET_COCO80 | YOLOv8 COCO80 detection model |
| TDL_MODEL_YOLOV10_DET_COCO80 | YOLOv10 COCO80 detection model |
| TDL_MODEL_YOLOV8N_DET_HAND | Hand detection model |
| TDL_MODEL_YOLOV8N_DET_PET_PERSON | Pet and person detection model (0: cat, 1: dog, 2: person) |
| TDL_MODEL_YOLOV8N_DET_PERSON_VEHICLE | Person and vehicle detection model (0: car, 1: bus, 2: truck, 3: motorcyclist, 4: person, 5: bicycle, 6: motorcycle) |
| TDL_MODEL_YOLOV8N_DET_HAND_FACE_PERSON | Hand, face and person detection model (0: hand, 1: face, 2: person) |
| TDL_MODEL_YOLOV8N_DET_HEAD_PERSON | Head detection model (0: person, 1: head) |
| TDL_MODEL_YOLOV8N_DET_HEAD_HARDHAT | Head and hard hat detection model (0: head, 1: hard hat) |
| TDL_MODEL_YOLOV8N_DET_FIRE_SMOKE | Fire and smoke detection model (0: fire, 1: smoke) |
| TDL_MODEL_YOLOV8N_DET_FIRE | Fire detection model (0: fire) |
| TDL_MODEL_YOLOV8N_DET_HEAD_SHOULDER | Head and shoulder detection model (0: head shoulder) |
| TDL_MODEL_YOLOV8N_DET_LICENSE_PLATE | License plate detection model (0: license plate) |
| TDL_MODEL_YOLOV8N_DET_TRAFFIC_LIGHT | Traffic light detection model (0: red, 1: yellow, 2: green, 3: off, 4: waiting) |
| TDL_MODEL_SCRFD_DET_FACE | Face detection model (0: face + keypoints) |
| TDL_MODEL_RETINA_DET_FACE | Face detection model |
| TDL_MODEL_RETINA_DET_FACE_IR | Infrared face detection model |
| TDL_MODEL_KEYPOINT_FACE_V2 | Face detection model with 5 keypoints + blur score |
| TDL_MODEL_CLS_ATTRIBUTE_FACE | Face attribute classification model (age, gender, glasses, mask) |
| TDL_MODEL_RESNET_FEATURE_BMFACE_R34 | ResNet34 512-dimension feature extraction model |
| TDL_MODEL_RESNET_FEATURE_BMFACE_R50 | ResNet50 512-dimension feature extraction model |
| TDL_MODEL_CLS_MASK | Mask detection model (0: wearing mask, 1: not wearing mask) |
| TDL_MODEL_CLS_RGBLIVENESS | Liveness detection model (0: real, 1: fake) |
| TDL_MODEL_CLS_ISP_SCENE | ISP scene classification model |
| TDL_MODEL_CLS_HAND_GESTURE | Hand gesture classification model (0: fist, 1: five fingers, 2: none, 3: two) |
| TDL_MODEL_CLS_KEYPOINT_HAND_GESTURE | Hand gesture keypoint classification model (0: fist, 1: five fingers, 2: four fingers, 3: none, 4: ok, 5: one, 6: three, 7: three 2, 8: two) |
| TDL_MODEL_CLS_SOUND_BABY_CRY | Baby cry classification model (0: background, 1: crying) |
| TDL_MODEL_CLS_SOUND_COMMAND | Voice command classification model |
| TDL_MODEL_KEYPOINT_LICENSE_PLATE | License plate keypoint detection model |
| TDL_MODEL_KEYPOINT_HAND | Hand keypoint detection model |
| TDL_MODEL_KEYPOINT_YOLOV8POSE_PERSON17 | Human 17 keypoints detection model |
| TDL_MODEL_KEYPOINT_SIMCC_PERSON17 | SIMCC 17 keypoints detection model |
| TDL_MODEL_LSTR_DET_LANE | Lane detection model |
| TDL_MODEL_RECOGNITION_LICENSE_PLATE | License plate recognition model |
| TDL_MODEL_YOLOV8_SEG_COCO80 | YOLOv8 COCO80 segmentation model |
| TDL_MODEL_SEG_PERSON_FACE_VEHICLE | Person, face and vehicle segmentation model (0: background, 1: person, 2: face, 3: vehicle, 4: license plate) |
| TDL_MODEL_SEG_MOTION | Motion segmentation model (0: static, 2: transition, 3: motion) |
| TDL_MODEL_IMG_FEATURE_CLIP | Image feature extraction model |
| TDL_MODEL_TEXT_FEATURE_CLIP | Text feature extraction model |

---

## 2. Structure Reference

### 2.1 TDLDataTypeE

**Description:** Data type enumeration class

**Definition:**
```c
typedef enum {
    TDL_TYPE_INT8 = 0,      /**< Equals to int8_t. */
    TDL_TYPE_UINT8,         /**< Equals to uint8_t. */
    TDL_TYPE_INT16,         /**< Equals to int16_t. */
    TDL_TYPE_UINT16,        /**< Equals to uint16_t. */
    TDL_TYPE_INT32,         /**< Equals to int32_t. */
    TDL_TYPE_UINT32,        /**< Equals to uint32_t. */
    TDL_TYPE_BF16,          /**< Equals to bf16. */
    TDL_TYPE_FP16,          /**< Equals to fp16. */
    TDL_TYPE_FP32,          /**< Equals to fp32. */
    TDL_TYPE_UNKNOWN        /**< Equals to unknown. */
} TDLDataTypeE;
```

**Members:**
| Data Type | Description |
|-----------|-------------|
| TDL_TYPE_INT8 | Signed 8-bit integer |
| TDL_TYPE_UINT8 | Unsigned 8-bit integer |
| TDL_TYPE_INT16 | Signed 16-bit integer |
| TDL_TYPE_UINT16 | Unsigned 16-bit integer |
| TDL_TYPE_INT32 | Signed 32-bit integer |
| TDL_TYPE_UINT32 | Unsigned 32-bit integer |
| TDL_TYPE_BF16 | 16-bit floating point (1 sign bit, 8 exponent bits, 7 mantissa bits) |
| TDL_TYPE_FP16 | 16-bit floating point (1 sign bit, 5 exponent bits, 10 mantissa bits) |
| TDL_TYPE_FP32 | 32-bit floating point |

### 2.2 TDLBox

**Description:** Bounding box coordinate data

**Definition:**
```c
typedef struct {
    float x1;
    float y1;
    float x2;
    float y2;
} TDLBox;
```

**Members:**
| Member | Description |
|--------|-------------|
| x1 | Top-left x coordinate of the box |
| y1 | Top-left y coordinate of the box |
| x2 | Bottom-right x coordinate of the box |
| y2 | Bottom-right y coordinate of the box |

### 2.3 TDLFeature

**Description:** Feature value data

**Definition:**
```c
typedef struct {
    int8_t *ptr;
    uint32_t size;
    TDLDataTypeE type;
} TDLFeature;
```

**Members:**
| Member | Description |
|--------|-------------|
| ptr | Feature value data |
| size | Data size |
| type | Data type |

### 2.4 TDLPoints

**Description:** Coordinate array data

**Definition:**
```c
typedef struct {
    float *x;
    float *y;
    uint32_t size;
    float score;
} TDLPoints;
```

**Members:**
| Member | Description |
|--------|-------------|
| x | X coordinate array data |
| y | Y coordinate array data |
| size | Size of coordinate array |
| score | Score |

### 2.5 TDLLandmarkInfo

**Description:** Landmark point information

**Definition:**
```c
typedef struct {
    float x;
    float y;
    float score;
} TDLLandmarkInfo;
```

**Members:**
| Member | Description |
|--------|-------------|
| x | X coordinate of landmark point |
| y | Y coordinate of landmark point |
| score | Score |

### 2.6 TDLObjectInfo

**Description:** Object detection information

**Definition:**
```c
typedef struct {
    TDLBox box;
    float score;
    int class_id;
    uint32_t landmark_size;
    TDLLandmarkInfo *landmark_property;
    TDLObjectTypeE obj_type;
} TDLObjectInfo;
```

**Members:**
| Member | Description |
|--------|-------------|
| box | Object detection bounding box |
| score | Object detection score |
| class_id | Object detection class ID |
| landmark_size | Size of object detection landmarks |
| landmark_property | Object detection landmark information |
| obj_type | Object detection type |

### 2.7 TDLObject

**Description:** Object detection data

**Definition:**
```c
typedef struct {
    uint32_t size;
    uint32_t width;
    uint32_t height;
    TDLObjectInfo *info;
} TDLObject;
```

**Members:**
| Member | Description |
|--------|-------------|
| size | Number of detected objects |
| width | Width of detection image |
| height | Height of detection image |
| info | Object detection information |

### 2.8 TDLFaceInfo

**Description:** Face information

**Definition:**
```c
typedef struct {
    char name[128];
    float score;
    uint64_t track_id;
    TDLBox box;
    TDLPoints landmarks;
    TDLFeature feature;
    float gender_score;
    float glass_score;
    float age;
    float liveness_score;
    float hardhat_score;
    float mask_score;
    float recog_score;
    float face_quality;
    float pose_score;
    float blurness;
} TDLFaceInfo;
```

**Members:**
| Member | Description |
|--------|-------------|
| name | Face name |
| score | Face score |
| track_id | Face tracking ID |
| box | Face bounding box information |
| landmarks | Face landmarks |
| feature | Face feature values |
| gender_score | Face gender score |
| glass_score | Whether face is wearing glasses |
| age | Face age |
| liveness_score | Face liveness score |
| hardhat_score | Whether face is wearing hard hat score |
| mask_score | Face mask detection score |
| recog_score | Face recognition score |
| face_quality | Face quality score |
| pose_score | Face pose score |
| blurness | Face blur level |

### 2.9 TDLFace

**Description:** Face data

**Definition:**
```c
typedef struct {
    uint32_t size;
    uint32_t width;
    uint32_t height;
    TDLFaceInfo *info;
} TDLFace;
```

**Members:**
| Member | Description |
|--------|-------------|
| size | Number of faces |
| width | Width of face image |
| height | Height of face image |
| info | Face information |

### 2.10 TDLClassInfo

**Description:** Classification information

**Definition:**
```c
typedef struct {
    int32_t class_id;
    float score;
} TDLClassInfo;
```

**Members:**
| Member | Description |
|--------|-------------|
| class_id | Classification class |
| score | Classification score |

### 2.11 TDLClass

**Description:** Classification data

**Definition:**
```c
typedef struct {
    uint32_t size;
    TDLClassInfo *info;
} TDLClass;
```

**Members:**
| Member | Description |
|--------|-------------|
| size | Number of classifications |
| info | Classification information |

### 2.12 TDLKeypointInfo

**Description:** Keypoint information

**Definition:**
```c
typedef struct {
    float x;
    float y;
    float score;
} TDLKeypointInfo;
```

**Members:**
| Member | Description |
|--------|-------------|
| x | X coordinate of keypoint |
| y | Y coordinate of keypoint |
| score | Keypoint score |

### 2.13 TDLKeypoint

**Description:** Keypoint data

**Definition:**
```c
typedef struct {
    uint32_t size;
    uint32_t width;
    uint32_t height;
    TDLKeypointInfo *info;
} TDLKeypoint;
```

**Members:**
| Member | Description |
|--------|-------------|
| size | Number of keypoints |
| width | Image width |
| height | Image height |
| info | Keypoint information |

### 2.14 TDLSegmentation

**Description:** Semantic segmentation data

**Definition:**
```c
typedef struct {
    uint32_t width;
    uint32_t height;
    uint32_t output_width;
    uint32_t output_height;
    uint8_t *class_id;
    uint8_t *class_conf;
} TDLSegmentation;
```

**Members:**
| Member | Description |
|--------|-------------|
| width | Image width |
| height | Image height |
| output_width | Output image width |
| output_height | Output image height |
| class_id | Classification class |
| class_conf | Classification coordinate information |

### 2.15 TDLInstanceSegInfo

**Description:** Instance segmentation information

**Definition:**
```c
typedef struct {
    uint8_t *mask;
    float *mask_point;
    uint32_t mask_point_size;
    TDLObjectInfo *obj_info;
} TDLInstanceSegInfo;
```

**Members:**
| Member | Description |
|--------|-------------|
| mask | Instance segmentation mask array |
| mask_point | Instance segmentation mask_point array |
| mask_point_size | Number of instance segmentation points |
| obj_info | Instance segmentation object detection information |

### 2.16 TDLInstanceSeg

**Description:** Instance segmentation data

**Definition:**
```c
typedef struct {
    uint32_t size;
    uint32_t width;
    uint32_t height;
    uint32_t mask_width;
    uint32_t mask_height;
    TDLInstanceSegInfo *info;
} TDLInstanceSeg;
```

**Members:**
| Member | Description |
|--------|-------------|
| size | Number of instance segmentations |
| width | Image width |
| height | Image height |
| mask_width | Mask width |
| mask_height | Mask height |
| info | Instance segmentation information |

### 2.17 TDLLanePoint

**Description:** Lane detection coordinate points

**Definition:**
```c
typedef struct {
    float x[2];
    float y[2];
    float score;
} TDLLanePoint;
```

**Members:**
| Member | Description |
|--------|-------------|
| x | X coordinate array |
| y | Y coordinate array |
| score | Lane detection score |

### 2.18 TDLLane

**Description:** Lane detection data

**Definition:**
```c
typedef struct {
    uint32_t size;
    uint32_t width;
    uint32_t height;
    TDLLanePoint *lane;
    int lane_state;
} TDLLane;
```

**Members:**
| Member | Description |
|--------|-------------|
| size | Number of lane detections |
| width | Image width |
| height | Image height |
| lane | Lane detection coordinate points |
| lane_state | Lane state |

### 2.19 TDLDepthLogits

**Description:** Depth estimation data

**Definition:**
```c
typedef struct {
    int w;
    int h;
    int8_t *int_logits;
} TDLDepthLogits;
```

**Members:**
| Member | Description |
|--------|-------------|
| w | Image width |
| h | Image height |
| int_logits | Depth estimation information |

### 2.20 TDLTracker

**Description:** Tracking data

**Definition:**
```c
typedef struct {
    uint32_t size;
    uint64_t id;
    TDLBox bbox;
    int out_num;
} TDLTracker;
```

**Members:**
| Member | Description |
|--------|-------------|
| size | Number of tracking targets |
| id | Tracking target ID |
| bbox | Tracking target bounding box |
| out_num | Number of times tracking target was lost |

### 2.21 TDLOcr

**Description:** Text recognition data

**Definition:**
```c
typedef struct {
    uint32_t size;
    char* text_info;
} TDLOcr;
```

**Members:**
| Member | Description |
|--------|-------------|
| size | Number of text recognitions |
| text_info | Text recognition information |

---

## 3. API Reference

### 3.1 Handles

**Syntax:**
```c
typedef void *TDLHandle;
typedef void *TDLImage;
```

**Description:**
TDL SDK handles. TDLHandle is the core operation handle, TDLImage is the image data abstraction handle.

### 3.2 TDL_CreateHandle

**Syntax:**
```c
TDLHandle TDL_CreateHandle(const int32_t tpu_device_id);
```

**Description:**
Creates a TDLHandle object.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | const int32_t tpu_device_id | Specify TPU device ID |

### 3.3 TDL_DestroyHandle

**Syntax:**
```c
int32_t TDL_DestroyHandle(TDLHandle handle);
```

**Description:**
Destroys a TDLHandle object.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object to destroy |

### 3.4 TDL_WrapVPSSFrame

**Syntax:**
```c
TDLImage TDL_WrapVPSSFrame(void *vpss_frame, bool own_memory);
```

**Description:**
Wraps a VPSS frame as a TDLImageHandle object.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | void* vpss_frame | VPSS frame to wrap |
| Input | bool own_memory | Whether to own memory ownership |

### 3.5 TDL_ReadImage

**Syntax:**
```c
TDLImage TDL_ReadImage(const char *path);
```

**Description:**
Reads an image as a TDLImageHandle object.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | const char* path | Image path |

### 3.6 TDL_ReadAudio

**Syntax:**
```c
TDLImage TDL_ReadAudio(const char *path, int frame_size);
```

**Description:**
Reads an audio file as a TDLImageHandle object.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | const char* path | Audio path |
| Input | int frame_size | Audio data size |

### 3.7 TDL_DestroyImage

**Syntax:**
```c
int32_t TDL_DestroyImage(TDLImage image_handle);
```

**Description:**
Destroys a TDLImageHandle object.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLImage image_handle | TDLImageHandle object to destroy |

### 3.8 TDL_OpenModel

**Syntax:**
```c
int32_t TDL_OpenModel(TDLHandle handle,
                      const TDLModel model_id,
                      const char *model_path);
```

**Description:**
Loads a specified type of model into the TDLHandle object.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | const char* model_path | Model path |

### 3.9 TDL_CloseModel

**Syntax:**
```c
int32_t TDL_CloseModel(TDLHandle handle,
                       const TDLModel model_id);
```

**Description:**
Unloads a specified type of model and releases related resources.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |

### 3.10 TDL_Detection

**Syntax:**
```c
int32_t TDL_Detection(TDLHandle handle,
                      const TDLModel model_id,
                      TDLImage image_handle,
                      TDLObject *object_meta);
```

**Description:**
Performs inference detection with the specified model and returns detection result metadata.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Output | TDLObject* object_meta | Output detection result metadata |

### 3.11 TDL_FaceDetection

**Syntax:**
```c
int32_t TDL_FaceDetection(TDLHandle handle,
                          const TDLModel model_id,
                          TDLImage image_handle,
                          TDLFace *face_meta);
```

**Description:**
Performs face detection and returns face detection result metadata.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Output | TDLFace* face_meta | Output face detection result metadata |

### 3.12 TDL_FaceAttribute

**Syntax:**
```c
int32_t TDL_FaceAttribute(TDLHandle handle,
                          const TDLModel model_id,
                          TDLImage image_handle,
                          TDLFace *face_meta);
```

**Description:**
Performs face attribute analysis, works with detected face boxes for feature analysis.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Input/Output | TDLFace* face_meta | Input face detection results, output supplemented attribute information |

### 3.13 TDL_FaceLandmark

**Syntax:**
```c
int32_t TDL_FaceLandmark(TDLHandle handle,
                         const TDLModel model_id,
                         TDLImage image_handle,
                         TDLFace *face_meta);
```

**Description:**
Performs face landmark detection, supplements landmark coordinates on existing face detection results.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Input/Output | TDLFace* face_meta | Input face detection results, output supplemented landmark coordinates |

### 3.14 TDL_Classification

**Syntax:**
```c
int32_t TDL_Classification(TDLHandle handle,
                           const TDLModel model_id,
                           TDLImage image_handle,
                           TDLClassInfo *class_info);
```

**Description:**
Performs general classification recognition.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Output | TDLClassInfo* class_info | Output classification results |

### 3.15 TDL_ObjectClassification

**Syntax:**
```c
int32_t TDL_ObjectClassification(TDLHandle handle,
                                 const TDLModel model_id,
                                 TDLImage image_handle,
                                 TDLObject *object_meta,
                                 TDLClass *class_info);
```

**Description:**
Performs fine-grained classification on detected objects.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Input | TDLObject* object_meta | Detected object information |
| Output | TDLClass* class_info | Output object classification results |

### 3.16 TDL_KeypointDetection

**Syntax:**
```c
int32_t TDL_KeypointDetection(TDLHandle handle,
                              const TDLModel model_id,
                              TDLImage image_handle,
                              TDLKeypoint *keypoint_meta);
```

**Description:**
Performs human/object keypoint detection.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Output | TDLKeypoint* keypoint_meta | Output keypoint coordinates and confidence |

### 3.17 TDL_InstanceSegmentation

**Syntax:**
```c
int32_t TDL_InstanceSegmentation(TDLHandle handle,
                                 const TDLModel model_id,
                                 TDLImage image_handle,
                                 TDLInstanceSeg *inst_seg_meta);
```

**Description:**
Performs instance segmentation, detecting pixel-level contours of each independent object in the image.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Output | TDLInstanceSeg* inst_seg_meta | Output instance segmentation results (including mask and bbox) |

### 3.18 TDL_SemanticSegmentation

**Syntax:**
```c
int32_t TDL_SemanticSegmentation(TDLHandle handle,
                                 const TDLModel model_id,
                                 TDLImage image_handle,
                                 TDLSegmentation *seg_meta);
```

**Description:**
Performs semantic segmentation, conducting pixel-level classification on images.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Output | TDLSegmentation* seg_meta | Output segmentation results (class label map) |

### 3.19 TDL_FeatureExtraction

**Syntax:**
```c
int32_t TDL_FeatureExtraction(TDLHandle handle,
                              const TDLModel model_id,
                              TDLImage image_handle,
                              TDLFeature *feature_meta);
```

**Description:**
Extracts deep feature vectors from images.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Output | TDLFeature* feature_meta | Output feature vectors |

### 3.20 TDL_LaneDetection

**Syntax:**
```c
int32_t TDL_LaneDetection(TDLHandle handle,
                          const TDLModel model_id,
                          TDLImage image_handle,
                          TDLLane *lane_meta);
```

**Description:**
Detects road lane lines and their attributes.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Output | TDLLane* lane_meta | Output lane line coordinates and attributes |

### 3.21 TDL_DepthStereo

**Syntax:**
```c
int32_t TDL_DepthStereo(TDLHandle handle,
                        const TDLModel model_id,
                        TDLImage image_handle,
                        TDLDepthLogits *depth_logits);
```

**Description:**
Depth estimation based on binocular stereo vision, outputs depth confidence map.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Output | TDLDepthLogits* depth_logits | Output depth confidence data |

### 3.22 TDL_Tracking

**Syntax:**
```c
int32_t TDL_Tracking(TDLHandle handle,
                     const TDLModel model_id,
                     TDLImage image_handle,
                     TDLObject *object_meta,
                     TDLTracker *tracker_meta);
```

**Description:**
Multi-object tracking, performs cross-frame object association based on detection results.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Input/Output | TDLObject* object_meta | Input detection results, output supplemented tracking IDs |
| Output | TDLTracker* tracker_meta | Output tracker status information |

### 3.23 TDL_CharacterRecognition

**Syntax:**
```c
int32_t TDL_CharacterRecognition(TDLHandle handle,
                                 const TDLModel model_id,
                                 TDLImage image_handle,
                                 TDLOcr *char_meta);
```

**Description:**
Character recognition, supports text detection and recognition.

**Parameters:**
| Data Type | Parameter Name | Description |
|-----------|----------------|-------------|
| Input | TDLHandle handle | TDLHandle object |
| Input | const TDLModel model_id | Model type enumeration |
| Input | TDLImage image_handle | TDLImageHandle object |
| Output | TDLOcr* char_meta | Output recognition results (text content and position) |

---

## Additional Notes

- All functions return `int32_t` status codes (0 for success, non-zero for error)
- Memory management for output structures should be handled by the application
- Ensure proper model loading before calling inference functions
- Handle cleanup is required to prevent memory leaks
- This SDK supports TPU acceleration for enhanced performance
