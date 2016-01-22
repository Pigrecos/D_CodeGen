
; b/gas/testsuite/gas/i386/x86-64-avx-gather-intel.d
bits 64

vgatherdpd xmm1,QWORD [rbp+xmm7*2+0x0],xmm2	
vgatherqpd xmm1,QWORD [rbp+xmm7*2+0x0],xmm2	
vgatherdpd ymm1,QWORD [rbp+xmm7*2+0x0],ymm2	
vgatherqpd ymm1,QWORD [rbp+ymm7*2+0x0],ymm2	
vgatherdpd xmm11,QWORD [r13+xmm14*2+0x0],xmm12	
vgatherqpd xmm11,QWORD [r13+xmm14*2+0x0],xmm12	
vgatherdpd ymm11,QWORD [r13+xmm14*2+0x0],ymm12	
vgatherqpd ymm11,QWORD [r13+ymm14*2+0x0],ymm12	
vgatherdpd ymm6,QWORD [xmm4*1+0x8],ymm5		
vgatherdpd ymm6,QWORD [xmm4*1-0x8],ymm5		
vgatherdpd ymm6,QWORD [xmm4*1+0x0],ymm5		
vgatherdpd ymm6,QWORD [xmm4*1+0x298],ymm5		
vgatherdpd ymm6,QWORD [xmm4*8+0x8],ymm5		
vgatherdpd ymm6,QWORD [xmm4*8-0x8],ymm5		
vgatherdpd ymm6,QWORD [xmm4*8+0x0],ymm5		
vgatherdpd ymm6,QWORD [xmm4*8+0x298],ymm5		
vgatherdpd ymm6,QWORD [xmm14*1+0x8],ymm5		
vgatherdpd ymm6,QWORD [xmm14*1-0x8],ymm5		
vgatherdpd ymm6,QWORD [xmm14*1+0x0],ymm5		
vgatherdpd ymm6,QWORD [xmm14*1+0x298],ymm5		
vgatherdpd ymm6,QWORD [xmm14*8+0x8],ymm5		
vgatherdpd ymm6,QWORD [xmm14*8-0x8],ymm5		
vgatherdpd ymm6,QWORD [xmm14*8+0x0],ymm5		
vgatherdpd ymm6,QWORD [xmm14*8+0x298],ymm5		
vgatherdps xmm1,DWORD [rbp+xmm7*2+0x0],xmm2	
vgatherqps xmm1,DWORD [rbp+xmm7*2+0x0],xmm2	
vgatherdps ymm1,DWORD [rbp+ymm7*2+0x0],ymm2	
vgatherqps xmm1,DWORD [rbp+ymm7*2+0x0],xmm2	
vgatherdps xmm11,DWORD [r13+xmm14*2+0x0],xmm12	
vgatherqps xmm11,DWORD [r13+xmm14*2+0x0],xmm12	
vgatherdps ymm11,DWORD [r13+ymm14*2+0x0],ymm12	
vgatherqps xmm11,DWORD [r13+ymm14*2+0x0],xmm12	
vgatherdps xmm6,DWORD [xmm4*1+0x8],xmm5		
vgatherdps xmm6,DWORD [xmm4*1-0x8],xmm5		
vgatherdps xmm6,DWORD [xmm4*1+0x0],xmm5		
vgatherdps xmm6,DWORD [xmm4*1+0x298],xmm5		
vgatherdps xmm6,DWORD [xmm4*8+0x8],xmm5		
vgatherdps xmm6,DWORD [xmm4*8-0x8],xmm5		
vgatherdps xmm6,DWORD [xmm4*8+0x0],xmm5		
vgatherdps xmm6,DWORD [xmm4*8+0x298],xmm5		
vgatherdps xmm6,DWORD [xmm14*1+0x8],xmm5		
vgatherdps xmm6,DWORD [xmm14*1-0x8],xmm5		
vgatherdps xmm6,DWORD [xmm14*1+0x0],xmm5		
vgatherdps xmm6,DWORD [xmm14*1+0x298],xmm5		
vgatherdps xmm6,DWORD [xmm14*8+0x8],xmm5		
vgatherdps xmm6,DWORD [xmm14*8-0x8],xmm5		
vgatherdps xmm6,DWORD [xmm14*8+0x0],xmm5		
vgatherdps xmm6,DWORD [xmm14*8+0x298],xmm5		
vpgatherdd xmm1,DWORD [rbp+xmm7*2+0x0],xmm2	
vpgatherqd xmm1,DWORD [rbp+xmm7*2+0x0],xmm2	
vpgatherdd ymm1,DWORD [rbp+ymm7*2+0x0],ymm2	
vpgatherqd xmm1,DWORD [rbp+ymm7*2+0x0],xmm2	
vpgatherdd xmm11,DWORD [r13+xmm14*2+0x0],xmm12	
vpgatherqd xmm11,DWORD [r13+xmm14*2+0x0],xmm12	
vpgatherdd ymm11,DWORD [r13+ymm14*2+0x0],ymm12	
vpgatherqd xmm11,DWORD [r13+ymm14*2+0x0],xmm12	
vpgatherdd xmm6,DWORD [xmm4*1+0x8],xmm5		
vpgatherdd xmm6,DWORD [xmm4*1-0x8],xmm5		
vpgatherdd xmm6,DWORD [xmm4*1+0x0],xmm5		
vpgatherdd xmm6,DWORD [xmm4*1+0x298],xmm5		
vpgatherdd xmm6,DWORD [xmm4*8+0x8],xmm5		
vpgatherdd xmm6,DWORD [xmm4*8-0x8],xmm5		
vpgatherdd xmm6,DWORD [xmm4*8+0x0],xmm5		
vpgatherdd xmm6,DWORD [xmm4*8+0x298],xmm5		
vpgatherdd xmm6,DWORD [xmm14*1+0x8],xmm5		
vpgatherdd xmm6,DWORD [xmm14*1-0x8],xmm5		
vpgatherdd xmm6,DWORD [xmm14*1+0x0],xmm5		
vpgatherdd xmm6,DWORD [xmm14*1+0x298],xmm5		
vpgatherdd xmm6,DWORD [xmm14*8+0x8],xmm5		
vpgatherdd xmm6,DWORD [xmm14*8-0x8],xmm5		
vpgatherdd xmm6,DWORD [xmm14*8+0x0],xmm5		
vpgatherdd xmm6,DWORD [xmm14*8+0x298],xmm5		
vpgatherdq xmm1,QWORD [rbp+xmm7*2+0x0],xmm2	
vpgatherqq xmm1,QWORD [rbp+xmm7*2+0x0],xmm2	
vpgatherdq ymm1,QWORD [rbp+xmm7*2+0x0],ymm2	
vpgatherqq ymm1,QWORD [rbp+ymm7*2+0x0],ymm2	
vpgatherdq xmm11,QWORD [r13+xmm14*2+0x0],xmm12	
vpgatherqq xmm11,QWORD [r13+xmm14*2+0x0],xmm12	
vpgatherdq ymm11,QWORD [r13+xmm14*2+0x0],ymm12	
vpgatherqq ymm11,QWORD [r13+ymm14*2+0x0],ymm12	
vpgatherdq ymm6,QWORD [xmm4*1+0x8],ymm5		
vpgatherdq ymm6,QWORD [xmm4*1-0x8],ymm5		
vpgatherdq ymm6,QWORD [xmm4*1+0x0],ymm5		
vpgatherdq ymm6,QWORD [xmm4*1+0x298],ymm5		
vpgatherdq ymm6,QWORD [xmm4*8+0x8],ymm5		
vpgatherdq ymm6,QWORD [xmm4*8-0x8],ymm5		
vpgatherdq ymm6,QWORD [xmm4*8+0x0],ymm5		
vpgatherdq ymm6,QWORD [xmm4*8+0x298],ymm5		
vpgatherdq ymm6,QWORD [xmm14*1+0x8],ymm5		
vpgatherdq ymm6,QWORD [xmm14*1-0x8],ymm5		
vpgatherdq ymm6,QWORD [xmm14*1+0x0],ymm5		
vpgatherdq ymm6,QWORD [xmm14*1+0x298],ymm5		
vpgatherdq ymm6,QWORD [xmm14*8+0x8],ymm5		
vpgatherdq ymm6,QWORD [xmm14*8-0x8],ymm5		
vpgatherdq ymm6,QWORD [xmm14*8+0x0],ymm5		
vpgatherdq ymm6,QWORD [xmm14*8+0x298],ymm5		

; b/gas/testsuite/gas/i386/x86-64-avx2-intel.d
vpmaskmovd ymm6,ymm4,YWORD [rcx]			
vpmaskmovd YWORD [rcx],ymm6,ymm4			
vpmaskmovq ymm6,ymm4,YWORD [rcx]			
vpmaskmovq YWORD [rcx],ymm6,ymm4			
vpermpd ymm2,ymm6,0x7				
vpermpd ymm6,YWORD [rcx],0x7			
vpermq ymm2,ymm6,0x7				
vpermq ymm6,YWORD [rcx],0x7			
vpermd ymm2,ymm6,ymm4				
vpermd ymm2,ymm6,YWORD [rcx]			
vpermps ymm2,ymm6,ymm4				
vpermps ymm2,ymm6,YWORD [rcx]			
vpsllvd ymm2,ymm6,ymm4				
vpsllvd ymm2,ymm6,YWORD [rcx]			
vpsllvq ymm2,ymm6,ymm4				
vpsllvq ymm2,ymm6,YWORD [rcx]			
vpsravd ymm2,ymm6,ymm4				
vpsravd ymm2,ymm6,YWORD [rcx]			
vpsrlvd ymm2,ymm6,ymm4				
vpsrlvd ymm2,ymm6,YWORD [rcx]			
vpsrlvq ymm2,ymm6,ymm4				
vpsrlvq ymm2,ymm6,YWORD [rcx]			
vmovntdqa ymm4,YWORD [rcx]				
vbroadcastsd ymm6,xmm4				
vbroadcastss ymm6,xmm4				
vpblendd ymm2,ymm6,ymm4,0x7			
vpblendd ymm2,ymm6,YWORD [rcx],0x7			
vperm2i128 ymm2,ymm6,ymm4,0x7			
vperm2i128 ymm2,ymm6,YWORD [rcx],0x7		
vinserti128 ymm6,ymm4,xmm4,0x7			
vinserti128 ymm6,ymm4,OWORD [rcx],0x7		
vbroadcasti128 ymm4,OWORD [rcx]			
vpsllvd xmm2,xmm6,xmm4				
vpsllvd xmm7,xmm6,OWORD [rcx]			
vpsllvq xmm2,xmm6,xmm4				
vpsllvq xmm7,xmm6,OWORD [rcx]			
vpsravd xmm2,xmm6,xmm4				
vpsravd xmm7,xmm6,OWORD [rcx]			
vpsrlvd xmm2,xmm6,xmm4				
vpsrlvd xmm7,xmm6,OWORD [rcx]			
vpsrlvq xmm2,xmm6,xmm4				
vpsrlvq xmm7,xmm6,OWORD [rcx]			
vpmaskmovd xmm6,xmm4,OWORD [rcx]			
vpmaskmovq xmm6,xmm4,OWORD [rcx]			
vextracti128 xmm6,ymm4,0x7				
vextracti128 OWORD [rcx],ymm4,0x7			
vpmaskmovd OWORD [rcx],xmm6,xmm4			
vpmaskmovq OWORD [rcx],xmm6,xmm4			
vpblendd xmm2,xmm6,xmm4,0x7			
vpblendd xmm2,xmm6,OWORD [rcx],0x7			
vpbroadcastq xmm6,xmm4				
vpbroadcastq xmm4,QWORD [rcx]			
vpbroadcastq ymm6,xmm4				
vpbroadcastq ymm4,QWORD [rcx]			
vpbroadcastd ymm4,xmm4				
vpbroadcastd ymm4,DWORD [rcx]			
vpbroadcastd xmm6,xmm4				
vpbroadcastd xmm4,DWORD [rcx]			
vpbroadcastw xmm6,xmm4				
vpbroadcastw xmm4,WORD [rcx]			
vpbroadcastw ymm6,xmm4				
vpbroadcastw ymm4,WORD [rcx]			
vpbroadcastb xmm6,xmm4				
vpbroadcastb xmm4,BYTE [rcx]			
vpbroadcastb ymm6,xmm4				
vpbroadcastb ymm4,BYTE [rcx]			
vbroadcastss xmm6,xmm4				
vpmaskmovd ymm6,ymm4,YWORD [rcx]			
vpmaskmovd YWORD [rcx],ymm6,ymm4			
vpmaskmovd ymm6,ymm4,YWORD [rcx]			
vpmaskmovd YWORD [rcx],ymm6,ymm4			
vpmaskmovq ymm6,ymm4,YWORD [rcx]			
vpmaskmovq YWORD [rcx],ymm6,ymm4			
vpmaskmovq ymm6,ymm4,YWORD [rcx]			
vpmaskmovq YWORD [rcx],ymm6,ymm4			
vpermpd ymm2,ymm6,0x7				
vpermpd ymm6,YWORD [rcx],0x7			
vpermpd ymm6,YWORD [rcx],0x7			
vpermq ymm2,ymm6,0x7				
vpermq ymm6,YWORD [rcx],0x7			
vpermq ymm6,YWORD [rcx],0x7			
vpermd ymm2,ymm6,ymm4				
vpermd ymm2,ymm6,YWORD [rcx]			
vpermd ymm2,ymm6,YWORD [rcx]			
vpermps ymm2,ymm6,ymm4				
vpermps ymm2,ymm6,YWORD [rcx]			
vpermps ymm2,ymm6,YWORD [rcx]			
vpsllvd ymm2,ymm6,ymm4				
vpsllvd ymm2,ymm6,YWORD [rcx]			
vpsllvd ymm2,ymm6,YWORD [rcx]			
vpsllvq ymm2,ymm6,ymm4				
vpsllvq ymm2,ymm6,YWORD [rcx]			
vpsllvq ymm2,ymm6,YWORD [rcx]			
vpsravd ymm2,ymm6,ymm4				
vpsravd ymm2,ymm6,YWORD [rcx]			
vpsravd ymm2,ymm6,YWORD [rcx]			
vpsrlvd ymm2,ymm6,ymm4				
vpsrlvd ymm2,ymm6,YWORD [rcx]			
vpsrlvd ymm2,ymm6,YWORD [rcx]			
vpsrlvq ymm2,ymm6,ymm4				
vpsrlvq ymm2,ymm6,YWORD [rcx]			
vpsrlvq ymm2,ymm6,YWORD [rcx]			
vmovntdqa ymm4,YWORD [rcx]				
vmovntdqa ymm4,YWORD [rcx]				
vbroadcastsd ymm6,xmm4				
vbroadcastss ymm6,xmm4				
vpblendd ymm2,ymm6,ymm4,0x7			
vpblendd ymm2,ymm6,YWORD [rcx],0x7			
vpblendd ymm2,ymm6,YWORD [rcx],0x7			
vperm2i128 ymm2,ymm6,ymm4,0x7			
vperm2i128 ymm2,ymm6,YWORD [rcx],0x7		
vperm2i128 ymm2,ymm6,YWORD [rcx],0x7		
vinserti128 ymm6,ymm4,xmm4,0x7			
vinserti128 ymm6,ymm4,OWORD [rcx],0x7		
vinserti128 ymm6,ymm4,OWORD [rcx],0x7		
vbroadcasti128 ymm4,OWORD [rcx]			
vbroadcasti128 ymm4,OWORD [rcx]			
vpsllvd xmm2,xmm6,xmm4				
vpsllvd xmm7,xmm6,OWORD [rcx]			
vpsllvd xmm7,xmm6,OWORD [rcx]			
vpsllvq xmm2,xmm6,xmm4				
vpsllvq xmm7,xmm6,OWORD [rcx]			
vpsllvq xmm7,xmm6,OWORD [rcx]			
vpsravd xmm2,xmm6,xmm4				
vpsravd xmm7,xmm6,OWORD [rcx]			
vpsravd xmm7,xmm6,OWORD [rcx]			
vpsrlvd xmm2,xmm6,xmm4				
vpsrlvd xmm7,xmm6,OWORD [rcx]			
vpsrlvd xmm7,xmm6,OWORD [rcx]			
vpsrlvq xmm2,xmm6,xmm4				
vpsrlvq xmm7,xmm6,OWORD [rcx]			
vpsrlvq xmm7,xmm6,OWORD [rcx]			
vpmaskmovd xmm6,xmm4,OWORD [rcx]			
vpmaskmovd xmm6,xmm4,OWORD [rcx]			
vpmaskmovq xmm6,xmm4,OWORD [rcx]			
vpmaskmovq xmm6,xmm4,OWORD [rcx]			
vextracti128 xmm6,ymm4,0x7				
vextracti128 OWORD [rcx],ymm4,0x7			
vextracti128 OWORD [rcx],ymm4,0x7			
vpmaskmovd OWORD [rcx],xmm6,xmm4			
vpmaskmovd OWORD [rcx],xmm6,xmm4			
vpmaskmovq OWORD [rcx],xmm6,xmm4			
vpmaskmovq OWORD [rcx],xmm6,xmm4			
vpblendd xmm2,xmm6,xmm4,0x7			
vpblendd xmm2,xmm6,OWORD [rcx],0x7			
vpblendd xmm2,xmm6,OWORD [rcx],0x7			
vpbroadcastq xmm6,xmm4				
vpbroadcastq xmm4,QWORD [rcx]			
vpbroadcastq xmm4,QWORD [rcx]			
vpbroadcastq ymm6,xmm4				
vpbroadcastq ymm4,QWORD [rcx]			
vpbroadcastq ymm4,QWORD [rcx]			
vpbroadcastd ymm4,xmm4				
vpbroadcastd ymm4,DWORD [rcx]			
vpbroadcastd ymm4,DWORD [rcx]			
vpbroadcastd xmm6,xmm4				
vpbroadcastd xmm4,DWORD [rcx]			
vpbroadcastd xmm4,DWORD [rcx]			
vpbroadcastw xmm6,xmm4				
vpbroadcastw xmm4,WORD [rcx]			
vpbroadcastw xmm4,WORD [rcx]			
vpbroadcastw ymm6,xmm4				
vpbroadcastw ymm4,WORD [rcx]			
vpbroadcastw ymm4,WORD [rcx]			
vpbroadcastb xmm6,xmm4				
vpbroadcastb xmm4,BYTE [rcx]			
vpbroadcastb xmm4,BYTE [rcx]			
vpbroadcastb ymm6,xmm4				
vpbroadcastb ymm4,BYTE [rcx]			
vpbroadcastb ymm4,BYTE [rcx]			
vbroadcastss xmm6,xmm4				

; b/gas/testsuite/gas/i386/x86-64-avx256int-intel.d
vpmovmskb ecx,ymm4					
vpmovmskb ecx,ymm4					
vpslld ymm2,ymm6,0x7				
vpslldq ymm2,ymm6,0x7				
vpsllq ymm2,ymm6,0x7				
vpsllw ymm2,ymm6,0x7				
vpsrad ymm2,ymm6,0x7				
vpsraw ymm2,ymm6,0x7				
vpsrld ymm2,ymm6,0x7				
vpsrldq ymm2,ymm6,0x7				
vpsrlq ymm2,ymm6,0x7				
vpsrlw ymm2,ymm6,0x7				
vpshufd ymm2,ymm6,0x7				
vpshufd ymm6,YWORD [rcx],0x7			
vpshufhw ymm2,ymm6,0x7				
vpshufhw ymm6,YWORD [rcx],0x7			
vpshuflw ymm2,ymm6,0x7				
vpshuflw ymm6,YWORD [rcx],0x7			
vpackssdw ymm2,ymm6,ymm4				
vpackssdw ymm2,ymm6,YWORD [rcx]			
vpacksswb ymm2,ymm6,ymm4				
vpacksswb ymm2,ymm6,YWORD [rcx]			
vpackusdw ymm2,ymm6,ymm4				
vpackusdw ymm2,ymm6,YWORD [rcx]			
vpackuswb ymm2,ymm6,ymm4				
vpackuswb ymm2,ymm6,YWORD [rcx]			
vpaddb ymm2,ymm6,ymm4				
vpaddb ymm2,ymm6,YWORD [rcx]			
vpaddw ymm2,ymm6,ymm4				
vpaddw ymm2,ymm6,YWORD [rcx]			
vpaddd ymm2,ymm6,ymm4				
vpaddd ymm2,ymm6,YWORD [rcx]			
vpaddq ymm2,ymm6,ymm4				
vpaddq ymm2,ymm6,YWORD [rcx]			
vpaddsb ymm2,ymm6,ymm4				
vpaddsb ymm2,ymm6,YWORD [rcx]			
vpaddsw ymm2,ymm6,ymm4				
vpaddsw ymm2,ymm6,YWORD [rcx]			
vpaddusb ymm2,ymm6,ymm4				
vpaddusb ymm2,ymm6,YWORD [rcx]			
vpaddusw ymm2,ymm6,ymm4				
vpaddusw ymm2,ymm6,YWORD [rcx]			
vpand ymm2,ymm6,ymm4				
vpand ymm2,ymm6,YWORD [rcx]			
vpandn ymm2,ymm6,ymm4				
vpandn ymm2,ymm6,YWORD [rcx]			
vpavgb ymm2,ymm6,ymm4				
vpavgb ymm2,ymm6,YWORD [rcx]			
vpavgw ymm2,ymm6,ymm4				
vpavgw ymm2,ymm6,YWORD [rcx]			
vpcmpeqb ymm2,ymm6,ymm4				
vpcmpeqb ymm2,ymm6,YWORD [rcx]			
vpcmpeqw ymm2,ymm6,ymm4				
vpcmpeqw ymm2,ymm6,YWORD [rcx]			
vpcmpeqd ymm2,ymm6,ymm4				
vpcmpeqd ymm2,ymm6,YWORD [rcx]			
vpcmpeqq ymm2,ymm6,ymm4				
vpcmpeqq ymm2,ymm6,YWORD [rcx]			
vpcmpgtb ymm2,ymm6,ymm4				
vpcmpgtb ymm2,ymm6,YWORD [rcx]			
vpcmpgtw ymm2,ymm6,ymm4				
vpcmpgtw ymm2,ymm6,YWORD [rcx]			
vpcmpgtd ymm2,ymm6,ymm4				
vpcmpgtd ymm2,ymm6,YWORD [rcx]			
vpcmpgtq ymm2,ymm6,ymm4				
vpcmpgtq ymm2,ymm6,YWORD [rcx]			
vphaddw ymm2,ymm6,ymm4				
vphaddw ymm2,ymm6,YWORD [rcx]			
vphaddd ymm2,ymm6,ymm4				
vphaddd ymm2,ymm6,YWORD [rcx]			
vphaddsw ymm2,ymm6,ymm4				
vphaddsw ymm2,ymm6,YWORD [rcx]			
vphsubw ymm2,ymm6,ymm4				
vphsubw ymm2,ymm6,YWORD [rcx]			
vphsubd ymm2,ymm6,ymm4				
vphsubd ymm2,ymm6,YWORD [rcx]			
vphsubsw ymm2,ymm6,ymm4				
vphsubsw ymm2,ymm6,YWORD [rcx]			
vpmaddwd ymm2,ymm6,ymm4				
vpmaddwd ymm2,ymm6,YWORD [rcx]			
vpmaddubsw ymm2,ymm6,ymm4				
vpmaddubsw ymm2,ymm6,YWORD [rcx]			
vpmaxsb ymm2,ymm6,ymm4				
vpmaxsb ymm2,ymm6,YWORD [rcx]			
vpmaxsw ymm2,ymm6,ymm4				
vpmaxsw ymm2,ymm6,YWORD [rcx]			
vpmaxsd ymm2,ymm6,ymm4				
vpmaxsd ymm2,ymm6,YWORD [rcx]			
vpmaxub ymm2,ymm6,ymm4				
vpmaxub ymm2,ymm6,YWORD [rcx]			
vpmaxuw ymm2,ymm6,ymm4				
vpmaxuw ymm2,ymm6,YWORD [rcx]			
vpmaxud ymm2,ymm6,ymm4				
vpmaxud ymm2,ymm6,YWORD [rcx]			
vpminsb ymm2,ymm6,ymm4				
vpminsb ymm2,ymm6,YWORD [rcx]			
vpminsw ymm2,ymm6,ymm4				
vpminsw ymm2,ymm6,YWORD [rcx]			
vpminsd ymm2,ymm6,ymm4				
vpminsd ymm2,ymm6,YWORD [rcx]			
vpminub ymm2,ymm6,ymm4				
vpminub ymm2,ymm6,YWORD [rcx]			
vpminuw ymm2,ymm6,ymm4				
vpminuw ymm2,ymm6,YWORD [rcx]			
vpminud ymm2,ymm6,ymm4				
vpminud ymm2,ymm6,YWORD [rcx]			
vpmulhuw ymm2,ymm6,ymm4				
vpmulhuw ymm2,ymm6,YWORD [rcx]			
vpmulhrsw ymm2,ymm6,ymm4				
vpmulhrsw ymm2,ymm6,YWORD [rcx]			
vpmulhw ymm2,ymm6,ymm4				
vpmulhw ymm2,ymm6,YWORD [rcx]			
vpmullw ymm2,ymm6,ymm4				
vpmullw ymm2,ymm6,YWORD [rcx]			
vpmulld ymm2,ymm6,ymm4				
vpmulld ymm2,ymm6,YWORD [rcx]			
vpmuludq ymm2,ymm6,ymm4				
vpmuludq ymm2,ymm6,YWORD [rcx]			
vpmuldq ymm2,ymm6,ymm4				
vpmuldq ymm2,ymm6,YWORD [rcx]			
vpor ymm2,ymm6,ymm4				
vpor ymm2,ymm6,YWORD [rcx]				
vpsadbw ymm2,ymm6,ymm4				
vpsadbw ymm2,ymm6,YWORD [rcx]			
vpshufb ymm2,ymm6,ymm4				
vpshufb ymm2,ymm6,YWORD [rcx]			
vpsignb ymm2,ymm6,ymm4				
vpsignb ymm2,ymm6,YWORD [rcx]			
vpsignw ymm2,ymm6,ymm4				
vpsignw ymm2,ymm6,YWORD [rcx]			
vpsignd ymm2,ymm6,ymm4				
vpsignd ymm2,ymm6,YWORD [rcx]			
vpsubb ymm2,ymm6,ymm4				
vpsubb ymm2,ymm6,YWORD [rcx]			
vpsubw ymm2,ymm6,ymm4				
vpsubw ymm2,ymm6,YWORD [rcx]			
vpsubd ymm2,ymm6,ymm4				
vpsubd ymm2,ymm6,YWORD [rcx]			
vpsubq ymm2,ymm6,ymm4				
vpsubq ymm2,ymm6,YWORD [rcx]			
vpsubsb ymm2,ymm6,ymm4				
vpsubsb ymm2,ymm6,YWORD [rcx]			
vpsubsw ymm2,ymm6,ymm4				
vpsubsw ymm2,ymm6,YWORD [rcx]			
vpsubusb ymm2,ymm6,ymm4				
vpsubusb ymm2,ymm6,YWORD [rcx]			
vpsubusw ymm2,ymm6,ymm4				
vpsubusw ymm2,ymm6,YWORD [rcx]			
vpunpckhbw ymm2,ymm6,ymm4				
vpunpckhbw ymm2,ymm6,YWORD [rcx]			
vpunpckhwd ymm2,ymm6,ymm4				
vpunpckhwd ymm2,ymm6,YWORD [rcx]			
vpunpckhdq ymm2,ymm6,ymm4				
vpunpckhdq ymm2,ymm6,YWORD [rcx]			
vpunpckhqdq ymm2,ymm6,ymm4				
vpunpckhqdq ymm2,ymm6,YWORD [rcx]			
vpunpcklbw ymm2,ymm6,ymm4				
vpunpcklbw ymm2,ymm6,YWORD [rcx]			
vpunpcklwd ymm2,ymm6,ymm4				
vpunpcklwd ymm2,ymm6,YWORD [rcx]			
vpunpckldq ymm2,ymm6,ymm4				
vpunpckldq ymm2,ymm6,YWORD [rcx]			
vpunpcklqdq ymm2,ymm6,ymm4				
vpunpcklqdq ymm2,ymm6,YWORD [rcx]			
vpxor ymm2,ymm6,ymm4				
vpxor ymm2,ymm6,YWORD [rcx]			
vpabsb ymm6,ymm4					
vpabsb ymm4,YWORD [rcx]				
vpabsw ymm6,ymm4					
vpabsw ymm4,YWORD [rcx]				
vpabsd ymm6,ymm4					
vpabsd ymm4,YWORD [rcx]				
vmpsadbw ymm2,ymm6,ymm4,0x7			
vmpsadbw ymm2,ymm6,YWORD [rcx],0x7			
vpalignr ymm2,ymm6,ymm4,0x7			
vpalignr ymm2,ymm6,YWORD [rcx],0x7			
vpblendw ymm2,ymm6,ymm4,0x7			
vpblendw ymm2,ymm6,YWORD [rcx],0x7			
vpblendvb ymm7,ymm2,ymm6,ymm4			
vpblendvb ymm7,ymm2,YWORD [rcx],ymm4		
vpsllw ymm2,ymm6,xmm4				
vpsllw ymm2,ymm6,OWORD [rcx]			
vpslld ymm2,ymm6,xmm4				
vpslld ymm2,ymm6,OWORD [rcx]			
vpsllq ymm2,ymm6,xmm4				
vpsllq ymm2,ymm6,OWORD [rcx]			
vpsraw ymm2,ymm6,xmm4				
vpsraw ymm2,ymm6,OWORD [rcx]			
vpsrad ymm2,ymm6,xmm4				
vpsrad ymm2,ymm6,OWORD [rcx]			
vpsrlw ymm2,ymm6,xmm4				
vpsrlw ymm2,ymm6,OWORD [rcx]			
vpsrld ymm2,ymm6,xmm4				
vpsrld ymm2,ymm6,OWORD [rcx]			
vpsrlq ymm2,ymm6,xmm4				
vpsrlq ymm2,ymm6,OWORD [rcx]			
vpmovsxbw ymm4,xmm4				
vpmovsxbw ymm4,OWORD [rcx]				
vpmovsxwd ymm4,xmm4				
vpmovsxwd ymm4,OWORD [rcx]				
vpmovsxdq ymm4,xmm4				
vpmovsxdq ymm4,OWORD [rcx]				
vpmovzxbw ymm4,xmm4				
vpmovzxbw ymm4,OWORD [rcx]				
vpmovzxwd ymm4,xmm4				
vpmovzxwd ymm4,OWORD [rcx]				
vpmovzxdq ymm4,xmm4				
vpmovzxdq ymm4,OWORD [rcx]				
vpmovsxbd ymm6,xmm4				
vpmovsxbd ymm4,QWORD [rcx]				
vpmovsxwq ymm6,xmm4				
vpmovsxwq ymm4,QWORD [rcx]				
vpmovzxbd ymm6,xmm4				
vpmovzxbd ymm4,QWORD [rcx]				
vpmovzxwq ymm6,xmm4				
vpmovzxwq ymm4,QWORD [rcx]				
vpmovsxbq ymm4,xmm4				
vpmovsxbq ymm4,DWORD [rcx]				
vpmovzxbq ymm4,xmm4				
vpmovzxbq ymm4,DWORD [rcx]				
vpmovmskb ecx,ymm4					
vpmovmskb ecx,ymm4					
vpslld ymm2,ymm6,0x7				
vpslldq ymm2,ymm6,0x7				
vpsllq ymm2,ymm6,0x7				
vpsllw ymm2,ymm6,0x7				
vpsrad ymm2,ymm6,0x7				
vpsraw ymm2,ymm6,0x7				
vpsrld ymm2,ymm6,0x7				
vpsrldq ymm2,ymm6,0x7				
vpsrlq ymm2,ymm6,0x7				
vpsrlw ymm2,ymm6,0x7				
vpshufd ymm2,ymm6,0x7				
vpshufd ymm6,YWORD [rcx],0x7			
vpshufd ymm6,YWORD [rcx],0x7			
vpshufhw ymm2,ymm6,0x7				
vpshufhw ymm6,YWORD [rcx],0x7			
vpshufhw ymm6,YWORD [rcx],0x7			
vpshuflw ymm2,ymm6,0x7				
vpshuflw ymm6,YWORD [rcx],0x7			
vpshuflw ymm6,YWORD [rcx],0x7			
vpackssdw ymm2,ymm6,ymm4				
vpackssdw ymm2,ymm6,YWORD [rcx]			
vpackssdw ymm2,ymm6,YWORD [rcx]			
vpacksswb ymm2,ymm6,ymm4				
vpacksswb ymm2,ymm6,YWORD [rcx]			
vpacksswb ymm2,ymm6,YWORD [rcx]			
vpackusdw ymm2,ymm6,ymm4				
vpackusdw ymm2,ymm6,YWORD [rcx]			
vpackusdw ymm2,ymm6,YWORD [rcx]			
vpackuswb ymm2,ymm6,ymm4				
vpackuswb ymm2,ymm6,YWORD [rcx]			
vpackuswb ymm2,ymm6,YWORD [rcx]			
vpaddb ymm2,ymm6,ymm4				
vpaddb ymm2,ymm6,YWORD [rcx]			
vpaddb ymm2,ymm6,YWORD [rcx]			
vpaddw ymm2,ymm6,ymm4				
vpaddw ymm2,ymm6,YWORD [rcx]			
vpaddw ymm2,ymm6,YWORD [rcx]			
vpaddd ymm2,ymm6,ymm4				
vpaddd ymm2,ymm6,YWORD [rcx]			
vpaddd ymm2,ymm6,YWORD [rcx]			
vpaddq ymm2,ymm6,ymm4				
vpaddq ymm2,ymm6,YWORD [rcx]			
vpaddq ymm2,ymm6,YWORD [rcx]			
vpaddsb ymm2,ymm6,ymm4				
vpaddsb ymm2,ymm6,YWORD [rcx]			
vpaddsb ymm2,ymm6,YWORD [rcx]			
vpaddsw ymm2,ymm6,ymm4				
vpaddsw ymm2,ymm6,YWORD [rcx]			
vpaddsw ymm2,ymm6,YWORD [rcx]			
vpaddusb ymm2,ymm6,ymm4				
vpaddusb ymm2,ymm6,YWORD [rcx]			
vpaddusb ymm2,ymm6,YWORD [rcx]			
vpaddusw ymm2,ymm6,ymm4				
vpaddusw ymm2,ymm6,YWORD [rcx]			
vpaddusw ymm2,ymm6,YWORD [rcx]			
vpand ymm2,ymm6,ymm4				
vpand ymm2,ymm6,YWORD [rcx]			
vpand ymm2,ymm6,YWORD [rcx]			
vpandn ymm2,ymm6,ymm4				
vpandn ymm2,ymm6,YWORD [rcx]			
vpandn ymm2,ymm6,YWORD [rcx]			
vpavgb ymm2,ymm6,ymm4				
vpavgb ymm2,ymm6,YWORD [rcx]			
vpavgb ymm2,ymm6,YWORD [rcx]			
vpavgw ymm2,ymm6,ymm4				
vpavgw ymm2,ymm6,YWORD [rcx]			
vpavgw ymm2,ymm6,YWORD [rcx]			
vpcmpeqb ymm2,ymm6,ymm4				
vpcmpeqb ymm2,ymm6,YWORD [rcx]			
vpcmpeqb ymm2,ymm6,YWORD [rcx]			
vpcmpeqw ymm2,ymm6,ymm4				
vpcmpeqw ymm2,ymm6,YWORD [rcx]			
vpcmpeqw ymm2,ymm6,YWORD [rcx]			
vpcmpeqd ymm2,ymm6,ymm4				
vpcmpeqd ymm2,ymm6,YWORD [rcx]			
vpcmpeqd ymm2,ymm6,YWORD [rcx]			
vpcmpeqq ymm2,ymm6,ymm4				
vpcmpeqq ymm2,ymm6,YWORD [rcx]			
vpcmpeqq ymm2,ymm6,YWORD [rcx]			
vpcmpgtb ymm2,ymm6,ymm4				
vpcmpgtb ymm2,ymm6,YWORD [rcx]			
vpcmpgtb ymm2,ymm6,YWORD [rcx]			
vpcmpgtw ymm2,ymm6,ymm4				
vpcmpgtw ymm2,ymm6,YWORD [rcx]			
vpcmpgtw ymm2,ymm6,YWORD [rcx]			
vpcmpgtd ymm2,ymm6,ymm4				
vpcmpgtd ymm2,ymm6,YWORD [rcx]			
vpcmpgtd ymm2,ymm6,YWORD [rcx]			
vpcmpgtq ymm2,ymm6,ymm4				
vpcmpgtq ymm2,ymm6,YWORD [rcx]			
vpcmpgtq ymm2,ymm6,YWORD [rcx]			
vphaddw ymm2,ymm6,ymm4				
vphaddw ymm2,ymm6,YWORD [rcx]			
vphaddw ymm2,ymm6,YWORD [rcx]			
vphaddd ymm2,ymm6,ymm4				
vphaddd ymm2,ymm6,YWORD [rcx]			
vphaddd ymm2,ymm6,YWORD [rcx]			
vphaddsw ymm2,ymm6,ymm4				
vphaddsw ymm2,ymm6,YWORD [rcx]			
vphaddsw ymm2,ymm6,YWORD [rcx]			
vphsubw ymm2,ymm6,ymm4				
vphsubw ymm2,ymm6,YWORD [rcx]			
vphsubw ymm2,ymm6,YWORD [rcx]			
vphsubd ymm2,ymm6,ymm4				
vphsubd ymm2,ymm6,YWORD [rcx]			
vphsubd ymm2,ymm6,YWORD [rcx]			
vphsubsw ymm2,ymm6,ymm4				
vphsubsw ymm2,ymm6,YWORD [rcx]			
vphsubsw ymm2,ymm6,YWORD [rcx]			
vpmaddwd ymm2,ymm6,ymm4				
vpmaddwd ymm2,ymm6,YWORD [rcx]			
vpmaddwd ymm2,ymm6,YWORD [rcx]			
vpmaddubsw ymm2,ymm6,ymm4				
vpmaddubsw ymm2,ymm6,YWORD [rcx]			
vpmaddubsw ymm2,ymm6,YWORD [rcx]			
vpmaxsb ymm2,ymm6,ymm4				
vpmaxsb ymm2,ymm6,YWORD [rcx]			
vpmaxsb ymm2,ymm6,YWORD [rcx]			
vpmaxsw ymm2,ymm6,ymm4				
vpmaxsw ymm2,ymm6,YWORD [rcx]			
vpmaxsw ymm2,ymm6,YWORD [rcx]			
vpmaxsd ymm2,ymm6,ymm4				
vpmaxsd ymm2,ymm6,YWORD [rcx]			
vpmaxsd ymm2,ymm6,YWORD [rcx]			
vpmaxub ymm2,ymm6,ymm4				
vpmaxub ymm2,ymm6,YWORD [rcx]			
vpmaxub ymm2,ymm6,YWORD [rcx]			
vpmaxuw ymm2,ymm6,ymm4				
vpmaxuw ymm2,ymm6,YWORD [rcx]			
vpmaxuw ymm2,ymm6,YWORD [rcx]			
vpmaxud ymm2,ymm6,ymm4				
vpmaxud ymm2,ymm6,YWORD [rcx]			
vpmaxud ymm2,ymm6,YWORD [rcx]			
vpminsb ymm2,ymm6,ymm4				
vpminsb ymm2,ymm6,YWORD [rcx]			
vpminsb ymm2,ymm6,YWORD [rcx]			
vpminsw ymm2,ymm6,ymm4				
vpminsw ymm2,ymm6,YWORD [rcx]			
vpminsw ymm2,ymm6,YWORD [rcx]			
vpminsd ymm2,ymm6,ymm4				
vpminsd ymm2,ymm6,YWORD [rcx]			
vpminsd ymm2,ymm6,YWORD [rcx]			
vpminub ymm2,ymm6,ymm4				
vpminub ymm2,ymm6,YWORD [rcx]			
vpminub ymm2,ymm6,YWORD [rcx]			
vpminuw ymm2,ymm6,ymm4				
vpminuw ymm2,ymm6,YWORD [rcx]			
vpminuw ymm2,ymm6,YWORD [rcx]			
vpminud ymm2,ymm6,ymm4				
vpminud ymm2,ymm6,YWORD [rcx]			
vpminud ymm2,ymm6,YWORD [rcx]			
vpmulhuw ymm2,ymm6,ymm4				
vpmulhuw ymm2,ymm6,YWORD [rcx]			
vpmulhuw ymm2,ymm6,YWORD [rcx]			
vpmulhrsw ymm2,ymm6,ymm4				
vpmulhrsw ymm2,ymm6,YWORD [rcx]			
vpmulhrsw ymm2,ymm6,YWORD [rcx]			
vpmulhw ymm2,ymm6,ymm4				
vpmulhw ymm2,ymm6,YWORD [rcx]			
vpmulhw ymm2,ymm6,YWORD [rcx]			
vpmullw ymm2,ymm6,ymm4				
vpmullw ymm2,ymm6,YWORD [rcx]			
vpmullw ymm2,ymm6,YWORD [rcx]			
vpmulld ymm2,ymm6,ymm4				
vpmulld ymm2,ymm6,YWORD [rcx]			
vpmulld ymm2,ymm6,YWORD [rcx]			
vpmuludq ymm2,ymm6,ymm4				
vpmuludq ymm2,ymm6,YWORD [rcx]			
vpmuludq ymm2,ymm6,YWORD [rcx]			
vpmuldq ymm2,ymm6,ymm4				
vpmuldq ymm2,ymm6,YWORD [rcx]			
vpmuldq ymm2,ymm6,YWORD [rcx]			
vpor ymm2,ymm6,ymm4				
vpor ymm2,ymm6,YWORD [rcx]				
vpor ymm2,ymm6,YWORD [rcx]				
vpsadbw ymm2,ymm6,ymm4				
vpsadbw ymm2,ymm6,YWORD [rcx]			
vpsadbw ymm2,ymm6,YWORD [rcx]			
vpshufb ymm2,ymm6,ymm4				
vpshufb ymm2,ymm6,YWORD [rcx]			
vpshufb ymm2,ymm6,YWORD [rcx]			
vpsignb ymm2,ymm6,ymm4				
vpsignb ymm2,ymm6,YWORD [rcx]			
vpsignb ymm2,ymm6,YWORD [rcx]			
vpsignw ymm2,ymm6,ymm4				
vpsignw ymm2,ymm6,YWORD [rcx]			
vpsignw ymm2,ymm6,YWORD [rcx]			
vpsignd ymm2,ymm6,ymm4				
vpsignd ymm2,ymm6,YWORD [rcx]			
vpsignd ymm2,ymm6,YWORD [rcx]			
vpsubb ymm2,ymm6,ymm4				
vpsubb ymm2,ymm6,YWORD [rcx]			
vpsubb ymm2,ymm6,YWORD [rcx]			
vpsubw ymm2,ymm6,ymm4				
vpsubw ymm2,ymm6,YWORD [rcx]			
vpsubw ymm2,ymm6,YWORD [rcx]			
vpsubd ymm2,ymm6,ymm4				
vpsubd ymm2,ymm6,YWORD [rcx]			
vpsubd ymm2,ymm6,YWORD [rcx]			
vpsubq ymm2,ymm6,ymm4				
vpsubq ymm2,ymm6,YWORD [rcx]			
vpsubq ymm2,ymm6,YWORD [rcx]			
vpsubsb ymm2,ymm6,ymm4				
vpsubsb ymm2,ymm6,YWORD [rcx]			
vpsubsb ymm2,ymm6,YWORD [rcx]			
vpsubsw ymm2,ymm6,ymm4				
vpsubsw ymm2,ymm6,YWORD [rcx]			
vpsubsw ymm2,ymm6,YWORD [rcx]			
vpsubusb ymm2,ymm6,ymm4				
vpsubusb ymm2,ymm6,YWORD [rcx]			
vpsubusb ymm2,ymm6,YWORD [rcx]			
vpsubusw ymm2,ymm6,ymm4				
vpsubusw ymm2,ymm6,YWORD [rcx]			
vpsubusw ymm2,ymm6,YWORD [rcx]			
vpunpckhbw ymm2,ymm6,ymm4				
vpunpckhbw ymm2,ymm6,YWORD [rcx]			
vpunpckhbw ymm2,ymm6,YWORD [rcx]			
vpunpckhwd ymm2,ymm6,ymm4				
vpunpckhwd ymm2,ymm6,YWORD [rcx]			
vpunpckhwd ymm2,ymm6,YWORD [rcx]			
vpunpckhdq ymm2,ymm6,ymm4				
vpunpckhdq ymm2,ymm6,YWORD [rcx]			
vpunpckhdq ymm2,ymm6,YWORD [rcx]			
vpunpckhqdq ymm2,ymm6,ymm4				
vpunpckhqdq ymm2,ymm6,YWORD [rcx]			
vpunpckhqdq ymm2,ymm6,YWORD [rcx]			
vpunpcklbw ymm2,ymm6,ymm4				
vpunpcklbw ymm2,ymm6,YWORD [rcx]			
vpunpcklbw ymm2,ymm6,YWORD [rcx]			
vpunpcklwd ymm2,ymm6,ymm4				
vpunpcklwd ymm2,ymm6,YWORD [rcx]			
vpunpcklwd ymm2,ymm6,YWORD [rcx]			
vpunpckldq ymm2,ymm6,ymm4				
vpunpckldq ymm2,ymm6,YWORD [rcx]			
vpunpckldq ymm2,ymm6,YWORD [rcx]			
vpunpcklqdq ymm2,ymm6,ymm4				
vpunpcklqdq ymm2,ymm6,YWORD [rcx]			
vpunpcklqdq ymm2,ymm6,YWORD [rcx]			
vpxor ymm2,ymm6,ymm4				
vpxor ymm2,ymm6,YWORD [rcx]			
vpxor ymm2,ymm6,YWORD [rcx]			
vpabsb ymm6,ymm4					
vpabsb ymm4,YWORD [rcx]				
vpabsb ymm4,YWORD [rcx]				
vpabsw ymm6,ymm4					
vpabsw ymm4,YWORD [rcx]				
vpabsw ymm4,YWORD [rcx]				
vpabsd ymm6,ymm4					
vpabsd ymm4,YWORD [rcx]				
vpabsd ymm4,YWORD [rcx]				
vmpsadbw ymm2,ymm6,ymm4,0x7			
vmpsadbw ymm2,ymm6,YWORD [rcx],0x7			
vmpsadbw ymm2,ymm6,YWORD [rcx],0x7			
vpalignr ymm2,ymm6,ymm4,0x7			
vpalignr ymm2,ymm6,YWORD [rcx],0x7			
vpalignr ymm2,ymm6,YWORD [rcx],0x7			
vpblendw ymm2,ymm6,ymm4,0x7			
vpblendw ymm2,ymm6,YWORD [rcx],0x7			
vpblendw ymm2,ymm6,YWORD [rcx],0x7			
vpblendvb ymm7,ymm2,ymm6,ymm4			
vpblendvb ymm7,ymm2,YWORD [rcx],ymm4		
vpblendvb ymm7,ymm2,YWORD [rcx],ymm4		
vpsllw ymm2,ymm6,xmm4				
vpsllw ymm2,ymm6,OWORD [rcx]			
vpsllw ymm2,ymm6,OWORD [rcx]			
vpslld ymm2,ymm6,xmm4				
vpslld ymm2,ymm6,OWORD [rcx]			
vpslld ymm2,ymm6,OWORD [rcx]			
vpsllq ymm2,ymm6,xmm4				
vpsllq ymm2,ymm6,OWORD [rcx]			
vpsllq ymm2,ymm6,OWORD [rcx]			
vpsraw ymm2,ymm6,xmm4				
vpsraw ymm2,ymm6,OWORD [rcx]			
vpsraw ymm2,ymm6,OWORD [rcx]			
vpsrad ymm2,ymm6,xmm4				
vpsrad ymm2,ymm6,OWORD [rcx]			
vpsrad ymm2,ymm6,OWORD [rcx]			
vpsrlw ymm2,ymm6,xmm4				
vpsrlw ymm2,ymm6,OWORD [rcx]			
vpsrlw ymm2,ymm6,OWORD [rcx]			
vpsrld ymm2,ymm6,xmm4				
vpsrld ymm2,ymm6,OWORD [rcx]			
vpsrld ymm2,ymm6,OWORD [rcx]			
vpsrlq ymm2,ymm6,xmm4				
vpsrlq ymm2,ymm6,OWORD [rcx]			
vpsrlq ymm2,ymm6,OWORD [rcx]			
vpmovsxbw ymm4,xmm4				
vpmovsxbw ymm4,OWORD [rcx]				
vpmovsxbw ymm4,OWORD [rcx]				
vpmovsxwd ymm4,xmm4				
vpmovsxwd ymm4,OWORD [rcx]				
vpmovsxwd ymm4,OWORD [rcx]				
vpmovsxdq ymm4,xmm4				
vpmovsxdq ymm4,OWORD [rcx]				
vpmovsxdq ymm4,OWORD [rcx]				
vpmovzxbw ymm4,xmm4				
vpmovzxbw ymm4,OWORD [rcx]				
vpmovzxbw ymm4,OWORD [rcx]				
vpmovzxwd ymm4,xmm4				
vpmovzxwd ymm4,OWORD [rcx]				
vpmovzxwd ymm4,OWORD [rcx]				
vpmovzxdq ymm4,xmm4				
vpmovzxdq ymm4,OWORD [rcx]				
vpmovzxdq ymm4,OWORD [rcx]				
vpmovsxbd ymm6,xmm4				
vpmovsxbd ymm4,QWORD [rcx]				
vpmovsxbd ymm4,QWORD [rcx]				
vpmovsxwq ymm6,xmm4				
vpmovsxwq ymm4,QWORD [rcx]				
vpmovsxwq ymm4,QWORD [rcx]				
vpmovzxbd ymm6,xmm4				
vpmovzxbd ymm4,QWORD [rcx]				
vpmovzxbd ymm4,QWORD [rcx]				
vpmovzxwq ymm6,xmm4				
vpmovzxwq ymm4,QWORD [rcx]				
vpmovzxwq ymm4,QWORD [rcx]				
vpmovsxbq ymm4,xmm4				
vpmovsxbq ymm4,DWORD [rcx]				
vpmovsxbq ymm4,DWORD [rcx]				
vpmovzxbq ymm4,xmm4				
vpmovzxbq ymm4,DWORD [rcx]				
vpmovzxbq ymm4,DWORD [rcx]	