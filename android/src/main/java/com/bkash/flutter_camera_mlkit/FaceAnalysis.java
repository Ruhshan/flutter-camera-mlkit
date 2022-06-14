package com.bkash.flutter_camera_mlkit;

import android.content.Context;
import android.os.Build;

import androidx.annotation.RequiresApi;

import com.google.mlkit.vision.camera.CameraSourceConfig;
import com.google.mlkit.vision.camera.CameraXSource;
import com.google.mlkit.vision.common.InputImage;
import com.google.mlkit.vision.face.Face;
import com.google.mlkit.vision.face.FaceDetection;
import com.google.mlkit.vision.camera.DetectionTaskCallback;
import com.google.mlkit.vision.face.FaceDetector;
import com.google.mlkit.vision.face.FaceDetectorOptions;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class FaceAnalysis {
    private FaceDetector faceDetector;
    private Map<String, FaceDetector> detectorMap=new HashMap<>();




    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    private void onDetectionTaskSuccess(List<Face> results, MethodChannel.Result result){
        for(Face face:results){


            //String res = "smiling_prob:"+face.getSmilingProbability()+"|left_eye_open:"+face.getLeftEyeOpenProbability()+"|right_eye_open"+face.getRightEyeOpenProbability();
            String res = "Rect_LTRB:("+face.getBoundingBox().left+","+face.getBoundingBox().top+","+
                    face.getBoundingBox().right+","+face.getBoundingBox().bottom+")";
            System.out.println(res);
            result.success(res);

        }
    }
    private void onDetectionTaskFailure(Exception e) {
        System.out.println("Detection task failed"+ e.getMessage());
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public void analyseFaceFromInputImage(MethodCall call, Context context, MethodChannel.Result result){

        Map<String, Object> imageData = (Map<String, Object>) call.argument("image_data");
        InputImage inputImage = InputImageConverter.getInputImageFromData(imageData, context);
        //System.out.println("Feeding image");

        String id="12121";

        faceDetector = detectorMap.get(id);
        if(faceDetector==null){

            FaceDetectorOptions highAccuracyOpts =
                    new FaceDetectorOptions.Builder()
                            .setPerformanceMode(FaceDetectorOptions.PERFORMANCE_MODE_FAST)
                            .setLandmarkMode(FaceDetectorOptions.LANDMARK_MODE_ALL)
                            .setClassificationMode(FaceDetectorOptions.CLASSIFICATION_MODE_ALL)
                            .build();


            faceDetector = FaceDetection.getClient(highAccuracyOpts);
            detectorMap.put(id, faceDetector);
        }

        faceDetector.process(inputImage).addOnSuccessListener(faces -> onDetectionTaskSuccess(faces, result));

    }

}
