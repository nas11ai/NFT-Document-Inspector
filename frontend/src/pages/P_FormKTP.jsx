import "../index.css";
import React from "react";

import FormKtp from "../components/page/FormKtp";
import Footer from "../components/page/Footer";
import NavBarNew from "../components/page/NavBarFunc";
import backgroundSvg from "../bcgr.svg";

export default function PageFormKtp() {
  return (
    <div
      className="flex flex-col bg-cover"
      style={{ backgroundImage: `url(${backgroundSvg})` }}
    >
      <div className="basis-auto">
        <NavBarNew />
      </div>
      <div className="h-auto">
        <FormKtp />
      </div>
      <div className="">
        <Footer />
      </div>
    </div>
  );
}
