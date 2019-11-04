// Based on https://blog.softwaremill.com/squeezing-extra-productivity-out-of-ammonite-scala-repl-b4e4001cca07

import $ivy.`org.typelevel::cats-core:2.0.0`, cats._, cats.implicits._
import $ivy.`io.monix::monix:3.0.0`
import $ivy.`dev.zio::zio:1.0.0-RC12-1`
import $ivy.`org.typelevel::cats-effect:2.0.0`
import $ivy.`org.scalatest::scalatest:3.0.8`,org.scalatest._
import $ivy.`org.scalacheck::scalacheck:1.14.0`
import $ivy.`com.github.chocpanda::scalacheck-magnolia:0.3.1`
import $ivy.`io.chrisdavenport::cats-scalacheck:0.2.0`

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._
import scala.concurrent.Future
import scala.util.{Failure, Success}
import scala.concurrent.Await
import org.scalacheck.{Arbitrary, Gen}
import org.scalacheck.magnolia._

def randomObj[T: Arbitrary] = implicitly[Arbitrary[T]].arbitrary.sample.get
