#include <stdint.h>
#include <vector>

class AxiPackedStencil_uint16_t_1_1_;

class PackedStencil_uint16_t_1_1_;

class Stencil_uint16_t_1_1_;

class AxiPackedStencil_uint16_t_1_1_ {
	uint16_t other_elems[1*1 + 20];
	uint16_t elems[1*1];
  public:
	void set_last(const int);
	AxiPackedStencil_uint16_t_1_1_();
	uint16_t operator()(const size_t e0=0, const size_t e1=0, const size_t e2=0);
	uint16_t get(const size_t e0=0, const size_t e1=0, const size_t e2=0);  
	void set(uint16_t, const size_t e0=0, const size_t e1=0, const size_t e2=0);  
	operator PackedStencil_uint16_t_1_1_();
	operator Stencil_uint16_t_1_1_();
};

class PackedStencil_uint16_t_1_1_ {
	uint16_t other_elems[1*1 + 20];
	uint16_t elems[1*1];
  public:
	PackedStencil_uint16_t_1_1_();
	operator AxiPackedStencil_uint16_t_1_1_();
	void set_last(const int);
	uint16_t operator()(const size_t e0=0, const size_t e1=0, const size_t e2=0);
};

class Stencil_uint16_t_1_1_ {
	uint16_t other_elems[1*1 + 20];
	uint16_t elems[1*1];
  public:
	Stencil_uint16_t_1_1_();
	Stencil_uint16_t_1_1_(const Stencil_uint16_t_1_1_&);
	Stencil_uint16_t_1_1_(const Stencil_uint16_t_1_1_&&);
	Stencil_uint16_t_1_1_& operator=(const Stencil_uint16_t_1_1_&);
	void set_last(const int);
	uint16_t operator()(const size_t e0=0, const size_t e1=0, const size_t e2=0);
	void write(uint16_t, const size_t e0=0, const size_t e1=0, const size_t e2=0);
	operator AxiPackedStencil_uint16_t_1_1_();
};

class hls_stream_AxiPackedStencil_uint16_t_1_1__ {
	int index;
	AxiPackedStencil_uint16_t_1_1_ elems[1000];
  public:
	hls_stream_AxiPackedStencil_uint16_t_1_1__();
	AxiPackedStencil_uint16_t_1_1_ read();
	void write(AxiPackedStencil_uint16_t_1_1_);
};


