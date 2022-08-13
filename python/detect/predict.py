import os
import tensorflow as tf
import numpy as np

category_index = {1: {'id': 1, 'name': 'tomato'}, 2: {'id': 2, 'name': 'egg'}, 3: {'id': 3, 'name': 'potato'},
                  4: {'id': 4, 'name': 'broccoli'}, 5: {'id': 5, 'name': 'beef'}, 6: {'id': 6, 'name': 'chicken'}}
Threshold = 0.5


def ExtractBBoxes(bboxes, bclasses, bscores, im_width, im_height):
    bbox = []
    class_labels = []
    for idx in range(len(bboxes)):
        if bscores[idx] >= Threshold:
            y_min = int(bboxes[idx][0] * im_height)
            x_min = int(bboxes[idx][1] * im_width)
            y_max = int(bboxes[idx][2] * im_height)
            x_max = int(bboxes[idx][3] * im_width)
            class_label = category_index[int(bclasses[idx])]['name']
            class_labels.append(class_label)
            bbox.append([x_min, y_min, x_max, y_max, class_label, float(bscores[idx])])
    return (bbox, class_labels)


def get_detections(IMAGE_PATH):

    detect_fn = tf.saved_model.load("my_ssd_mobnet/export/saved_model")

    image = tf.image.decode_image(open(IMAGE_PATH, 'rb').read(), channels=3)
    image = tf.image.resize(image, (180, 120))
    im_height, im_width, _ = image.shape

    input_tensor = np.expand_dims(image, 0)
    detections = detect_fn(input_tensor)

    bboxes = detections['detection_boxes'][0].numpy()
    bclasses = detections['detection_classes'][0].numpy().astype(np.int32)
    bscores = detections['detection_scores'][0].numpy()
    det_boxes, class_labels = ExtractBBoxes(bboxes, bclasses, bscores, im_width, im_height)
    return(class_labels)