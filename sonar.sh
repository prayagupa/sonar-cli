#!/bin/sh
exec scala "$0" "$@"
!#

import scala.util.parsing.json._

object Sonar {

  def main(args: Array[String]) {
   
    val Server = "http://sonar.shaharmainc.com"
    var Project = "shaharma-jenkins"

    val Endpoint = s"${Server}/api/issues/search?componentRoots=${Project}&statuses=OPEN"

    val result = scala.io.Source.fromURL(Endpoint).mkString
    val json = JSON.parseFull(result)

    json match {
      case Some(j:Map[String,Any]) => {
	    val issues = j("issues").asInstanceOf[List[Map[String, Any]]]
	    val issueList = JSONArray(issues)
	    println(issueList.toString())
      } 
      case None => println(s"{error : calling $Server failed.")
    } 
  }
}

Sonar.main(args)


//http://docs.sonarqube.org/pages/viewpage.action?pageId=2392181#WebService/api/issues-GetaListofIssues
//http://docs.sonarqube.org/pages/viewpage.action?pageId=2392166#WebService/api/rules-GetaListofRules
