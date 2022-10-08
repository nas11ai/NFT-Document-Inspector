import "../index.css";
import React from "react";
import NavBar from "../components/page/NavBar";
import FormKtp from "../components/page/FormKtp";
import Footer from "../components/page/Footer";
import NavBarNew from "../components/page/NavBarFunc";

export default function PageFormKtp() {
  return (
    <div className="flex flex-col h-screen justify-between bg-cyan-300">
      <NavBarNew/>
      <FormKtp />
      <Footer />
    </div>
  );
}
