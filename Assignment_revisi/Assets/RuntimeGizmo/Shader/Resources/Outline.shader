Shader "Custom/Outline"
{
    Properties
    {
        _OutlineColor ("Outline Color", Color) = (1, 0.5, 0, 1)
        _Outline ("Outline width", Range(0, 1)) = 0.1
    }
    SubShader
    {
        // Tag untuk URP
        Tags { "RenderType"="Transparent" "RenderPipeline"="UniversalPipeline" "Queue"="Transparent" }
        
        Pass
        {
            Name "Outline"
            Cull Front // Membalikkan wajah (Inverted Hull)
            ZWrite On
            Blend SrcAlpha OneMinusSrcAlpha

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
            };

            CBUFFER_START(UnityPerMaterial)
                float _Outline;
                half4 _OutlineColor;
            CBUFFER_END

            Varyings vert(Attributes input)
            {
                Varyings output;
                
                // Memperbesar ukuran vertex sesuai parameter _Outline
                float3 scaledPos = input.positionOS.xyz * (1.0 + _Outline);
                output.positionCS = TransformObjectToHClip(scaledPos);
                
                return output;
            }

            half4 frag(Varyings input) : SV_Target
            {
                return _OutlineColor;
            }
            ENDHLSL
        }
    }
}