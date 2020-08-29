﻿Shader "danbi/SimpleTextureMappingCullOff" {
  Properties{
    _TintColor("Tint Color", Color) = (1, 1, 1, 1)
    _MainTex("Texture", 2D) = "white" {}
  }

    SubShader{
      Tags { "RenderType" = "Opaque" }
      Cull Off

      Pass {
        CGPROGRAM
          #pragma vertex vert
          #pragma fragment frag            
          #include "UnityCG.cginc"

          struct appdata {
              float4 vertex : POSITION;
              float2 uv : TEXCOORD0;
          };

          struct v2f {
              float2 uv : TEXCOORD0;
              float4 vertex : SV_POSITION;
          };

          fixed4 _TintColor;
          sampler2D _MainTex;
          float4 _MainTex_ST;
		  float RotateAngleClockWise;
          v2f vert(appdata v) {
              v2f o;
              o.vertex = UnityObjectToClipPos(v.vertex);
              o.uv = TRANSFORM_TEX(v.uv, _MainTex);
              return o;
          }

          fixed4 frag(v2f i) : SV_Target {
			  i.uv.x = i.uv.x + (RotateAngleClockWise / 360);
            return tex2D(_MainTex, i.uv) * _TintColor;
          }
        ENDCG
      } // Pass
  } // SubShader
} // Shader