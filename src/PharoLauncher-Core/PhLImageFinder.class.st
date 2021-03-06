"
I can be used to find the URL of a Pharo image given the Pharo version and a build number or a sha referencing a Pharo version in the git repository.
It is generally useful to detect problems in a specific Pharo image build.
"
Class {
	#name : #PhLImageFinder,
	#superclass : #Object,
	#instVars : [
		'pharoVersion',
		'build',
		'sha'
	],
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #'instance creation' }
PhLImageFinder class >> pharoVersion: aPharoVersionString build: aPharoImageBuildNumberString [
	^ self new
		pharoVersion: aPharoVersionString build: aPharoImageBuildNumberString;
		yourself
]

{ #category : #'instance creation' }
PhLImageFinder class >> pharoVersion: aPharoVersionString sha: aPharoImageSha [
	^ self new
		pharoVersion: aPharoVersionString sha: aPharoImageSha;
		yourself
]

{ #category : #accessing }
PhLImageFinder >> buildNumber [
	^ build
]

{ #category : #'finding/searching' }
PhLImageFinder >> findUrl [
	| imagesListing templates matcher buildOrShaFilter imageListingUrl |
	
	imageListingUrl := self imageHtmlListingUrl.
	imagesListing := self htmlListingFor: imageListingUrl.
	buildOrShaFilter := self buildNumber 
		ifNil: [ '.sha.' , self sha , '.' ]
		ifNotNil: [ 'build.' , self buildNumber, '.sha.' ].
	templates := imagesListing lines 
		select: [ :line | 
			(line includesSubstring: buildOrShaFilter) 
				and: [ line includesSubstring: '64bit' ]].
	buildOrShaFilter := self buildNumber 
		ifNil: [ 'build\..+\.sha\.' , self sha , '\.' ]
		ifNotNil: [ 'build\.' , self buildNumber, '\.sha\.' ].
	matcher := ('.*href="(Pharo-?[0-9]+[.0]*-(SNAPSHOT|alpha)\.', buildOrShaFilter , '[^"]*64bit\.zip)"') asRegex.
	templates detect: [ :template | matcher matchesPrefix: template ].
	^ imageListingUrl , (matcher subexpression: 2)
]

{ #category : #fetching }
PhLImageFinder >> htmlListingFor: url [
	^ ZnClient new get: url
]

{ #category : #accessing }
PhLImageFinder >> imageHtmlListingUrl [
	^ 'https://files.pharo.org/image/', self pharoVersion , '0/'
]

{ #category : #accessing }
PhLImageFinder >> pharoVersion [
	^ pharoVersion
]

{ #category : #initialization }
PhLImageFinder >> pharoVersion: aPharoVersionString build: aPharoImageBuildNumberString [
	pharoVersion := aPharoVersionString.
	build := aPharoImageBuildNumberString
]

{ #category : #initialization }
PhLImageFinder >> pharoVersion: aPharoVersionString sha: aPharoImageSha [
	pharoVersion := aPharoVersionString.
	sha := aPharoImageSha 
]

{ #category : #accessing }
PhLImageFinder >> pharoVersionForImageListing [
	
	^ pharoVersion asNumber < 10
		ifTrue: [ pharoVersion , '.0' ]
		ifFalse: [ pharoVersion ]
]

{ #category : #accessing }
PhLImageFinder >> sha [ 
	^ sha
]
