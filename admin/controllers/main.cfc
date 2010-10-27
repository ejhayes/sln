/*
	Special Use Tracking System
    Copyright (c) 2010, California Department of Pesticide Regulation

	Provides view specific functionality for the admin area.
*/
component {
    function init(any fw){
        variables.fw = fw;
    }

	function index() {
		rc.title="Home";
        rc.designId="I-1.0";
	}
    
    function about(){
        rc.title="Overview";
        rc.designId="I-7.0";
    }
}